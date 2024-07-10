import 'dart:async';
import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/enums/car_on_map.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/core/util/enums/location_permission_status.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/location_single_sheet.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/cluste_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/cluster_item.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_clusters_usecase.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_location_usecase.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_map_locations_usecase.dart';
import 'package:i_watt_app/features/map/presentation/widgets/location_pin_widget.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_on_map_sheet.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetClustersUseCase getClustersUseCase;
  final GetMapLocationUseCase getLocationUseCase;
  final GetMapLocationsUseCase getLocationsUseCase;

  late final GoogleMapController mapController;
  late final ClusterManager clusterManager;
  late final BuildContext context;
  final List<MyClusterItem> clusterItems = [];

  MapBloc(this.getClustersUseCase, this.getLocationUseCase, this.getLocationsUseCase) : super(const MapState()) {
    clusterManager = ClusterManager<MyClusterItem>(
      clusterItems,
      (Set<Marker> markers) => add(SetMarkersEvent(markers: markers)),
      clusterAlgorithm: ClusterAlgorithm.MAX_DIST,
      stopClusteringZoom: 18,
      maxDistParams: MaxDistParams(8),
      markerBuilder: (Cluster<MyClusterItem> cluster) async {
        late final Uint8List appearence;
        if (cluster.isMultiple) {
          appearence = await _getClusterAppearance(
            placeCount: cluster.items.length,
            withLuminosity: false,
          );
          return Marker(
            markerId: MarkerId('cluster_${cluster.getId()}'),
            position: cluster.location,
            icon: BitmapDescriptor.fromBytes(appearence),
            onTap: () async {
              final point = _getAveragePointOfClusterPlacemarks(cluster.items.toList());
              final distance = _getDistanceBetweenClusterPlacemarks(cluster.items.toList());
              final zoom = _determineZoomLevel(distance).toDouble();
              mapController.animateCamera(CameraUpdate.newLatLngZoom(point, zoom));
            },
          );
        } else {
          return state.drawnMapObjects.firstWhere(
            (element) => element.markerId.value == 'location_${cluster.items.first.id}',
          );
        }
      },
    );
    on<SetFilteredLocations>(_setFilteredLocations);
    on<RequestLocationAccess>(_requestLocationAccess);
    on<CheckIfSettingsTriggered>(_checkIfSettingsTriggered);
    on<SetLocationAccessStateEvent>(_setLocationAccessState);
    on<SetMyPositionEvent>(_setMyPosition, transformer: droppable());
    on<InitializeMapControllerEvent>(_initializeController);
    on<ZoomInEvent>(_zoomIn, transformer: droppable());
    on<ZoomOutEvent>(_zoomOut, transformer: droppable());
    on<DrawChargeLocationsEvent>(_drawChargeLocation);
    on<ChangeLuminosityStateEvent>(_changeLuminosityState, transformer: droppable());
    on<SetCarOnMapEvent>(_setCarOnMap);
    on<GetAllLocationsEvent>(_getAllLocations);
    on<SetPresentPlaceMarks>(_setPresentPlaceMarks);
    on<CameraMovedEvent>(_cameraMoved);
    on<CameraIdled>(_cameraIdled);
    on<SetMarkersEvent>(_setMarkers);
    on<SetLocationSingleOpened>(_setLocationSingleOpened);
  }

  void _setMarkers(SetMarkersEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(presentedMapObjects: [...event.markers]));
  }

  void _getAllLocations(GetAllLocationsEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(drawingObjects: true));
    final result = await getLocationsUseCase.call(NoParams());
    if (result.isRight) {
      emit(state.copyWith(locations: [...result.right], filteredLocations: [...result.right]));
    }
  }

  void _initializeController(InitializeMapControllerEvent event, Emitter<MapState> emit) async {
    mapController = event.mapController;
    final lastLat = StorageRepository.getDouble(StorageKeys.latitude, defValue: -1);
    final lastLong = StorageRepository.getDouble(StorageKeys.longitude, defValue: -1);
    if (lastLat != -1 && lastLong != -1) _moveMapCamera(lastLat, lastLong, 16);
    context = event.context;
    clusterManager.setMapId(event.mapController.mapId);
    emit(state.copyWith(isMapInitialized: true));
  }

  void _setMyPosition(SetMyPositionEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(userLocationAccessingStatus: FormzSubmissionStatus.inProgress));
    final locationStatus = await MyFunctions.getWhetherPermissionGranted();
    if (locationStatus.isPermissionGranted) {
      final value = await MyFunctions.getCurrentLocation();
      if (value != null) {
        if (value.latitude != state.userCurrentLat || value.longitude != state.userCurrentLong || event.forceSet) {
          await StorageRepository.putDouble(StorageKeys.latitude, value.latitude);
          await StorageRepository.putDouble(StorageKeys.longitude, value.longitude);
          final newMarker = await MyFunctions.getMyIcon(
            context: context,
            value: LatLng(value.latitude, value.longitude),
            onObjectTap: () async {
              final isSame = await isSamePosition(LatLng(value.latitude, value.longitude));
              if (isSame) {
                showCarOnMapSheet(context);
              } else {
                _moveMapCamera(value.latitude, value.longitude, 16);
              }
            },
            userIcon: CarOnMap.defineType(StorageRepository.getString(StorageKeys.carOnMap)).imageOnMap,
          );
          emit(state.copyWith(
            userLocationObject: newMarker,
            userLocationAccessingStatus: FormzSubmissionStatus.success,
            userCurrentLat: value.latitude,
            userCurrentLong: value.longitude,
            locationAccessStatus: LocationPermissionStatus.permissionGranted,
          ));
        } else {
          emit(state.copyWith(userLocationAccessingStatus: FormzSubmissionStatus.success));
        }
        _moveMapCamera(value.latitude, value.longitude, 16);
        add(const ChangeLuminosityStateEvent(hasLuminosity: false));
      }
    } else {
      add(SetLocationAccessStateEvent(status: locationStatus));
    }
  }

  void _setCarOnMap(SetCarOnMapEvent event, Emitter<MapState> emit) async {
    if (state.locationAccessStatus.isPermissionGranted) {
      final position = LatLng(state.userCurrentLat, state.userCurrentLong);
      final newMarker = await MyFunctions.getMyIcon(
        context: context,
        value: position,
        onObjectTap: () async {
          final isSame = await isSamePosition(position);
          if (isSame) {
            showCarOnMapSheet(context);
          } else {
            _moveMapCamera(position.latitude, position.longitude, 16);
          }
        },
        userIcon: CarOnMap.defineType(StorageRepository.getString(StorageKeys.carOnMap)).imageOnMap,
      );
      emit(state.copyWith(userLocationObject: newMarker));
    }
  }

  void _setFilteredLocations(SetFilteredLocations event, Emitter<MapState> emit) {
    final allLocations = [...state.locations];
    final filtered = <ChargeLocationEntity>[];
    for (final location in event.locations) {
      final found = allLocations.firstWhere((element) => element.id == location.id, orElse: () => const ChargeLocationEntity());
      if (found.id != -1) {
        filtered.add(found);
      }
    }
    emit(state.copyWith(filteredLocations: filtered));
    add(SetPresentPlaceMarks(zoom: state.zoomLevel, point: state.cameraPosition));
  }

  void _setLocationAccessState(SetLocationAccessStateEvent event, Emitter<MapState> emit) {
    emit(
      state.copyWith(
        userLocationAccessingStatus: FormzSubmissionStatus.failure,
        locationAccessStatus: event.status,
      ),
    );
  }

  void _drawChargeLocation(DrawChargeLocationsEvent event, Emitter<MapState> emit) async {
    final locations = [...state.locations];
    final drawnMapObjects = <Marker>[];
    for (int i = 0; i < locations.length; i++) {
      final location = locations[i];
      final appearance = await _getLocationAppearance(
        logo: location.logo,
        stationStatuses: List<ConnectorStatus>.generate(
          location.connectorsStatus.length,
          (index) => ConnectorStatus.fromString(location.connectorsStatus[index]),
        ),
        // withLuminosity: event.withLuminosity,
        withLuminosity: false,
      );
      final position = LatLng(double.tryParse(location.latitude) ?? 0.0, double.tryParse(location.longitude) ?? 0.0);
      drawnMapObjects.add(
        Marker(
          markerId: MarkerId('location_${location.id}'),
          position: position,
          icon: BitmapDescriptor.fromBytes(appearance),
          onTap: () async {
            _moveMapCamera(position.latitude, position.longitude, 18);
            add(const SetLocationSingleOpened(isOpened: true));
            await showLocationSingle(context, location);
            add(const SetLocationSingleOpened(isOpened: false));
            // event.onLocationTap(location);
          },
        ),
      );
    }
    emit(state.copyWith(drawnMapObjects: drawnMapObjects, drawingObjects: false));
  }

  void _setLocationSingleOpened(SetLocationSingleOpened event, Emitter<MapState> emit) {
    emit(state.copyWith(locationSingleOpened: event.isOpened));
  }

  void _setPresentPlaceMarks(SetPresentPlaceMarks event, Emitter<MapState> emit) async {
    final newPoint = event.point ?? state.cameraPosition;
    final newZoom = event.zoom ?? state.zoomLevel;
    if (_canGet(newZoom, newPoint)) {
      final cItems = [];
      final filteredLocations = state.filteredLocations;
      final visibleRegion = await mapController.getVisibleRegion();
      for (final location in filteredLocations) {
        final locationPoint = LatLng(double.tryParse(location.latitude) ?? 0.0, double.tryParse(location.longitude) ?? 0.0);
        final isVisible = isLocationInVisibleRegion(locationPoint.latitude, locationPoint.longitude, visibleRegion);
        if (isVisible) {
          final clusterLocation = filteredLocations.firstWhere((element) => element.id == location.id);
          cItems.add(clusterLocation);
        }
      }
      clusterManager.setItems(List<MyClusterItem>.generate(cItems.length, (index) {
        final point = LatLng(double.tryParse(cItems[index].latitude) ?? 0.0, double.tryParse(cItems[index].longitude) ?? 0.0);
        return MyClusterItem(id: cItems[index].id, position: point);
      }));
      emit(state.copyWith(cameraPosition: event.point, zoomLevel: event.zoom));
    } else {
      emit(
        state.copyWith(
          drawingObjects: false,
          cameraPosition: event.point,
          zoomLevel: event.zoom,
        ),
      );
    }
  }

  void _checkIfSettingsTriggered(CheckIfSettingsTriggered event, Emitter<MapState> emit) async {
    if (state.locationSettingsTriggered) {
      emit(state.copyWith(locationSettingsTriggered: false));
      add(const SetMyPositionEvent());
    }
  }

  void _requestLocationAccess(RequestLocationAccess event, Emitter<MapState> emit) async {
    if (state.locationAccessStatus.isLocationServiceDisabled) {
      emit(state.copyWith(locationSettingsTriggered: true));
      await Geolocator.openLocationSettings();
    } else if (state.locationAccessStatus.isPermissionDenied) {
      emit(state.copyWith(locationSettingsTriggered: true));
      await Geolocator.openAppSettings();
    } else {
      add(const SetMyPositionEvent());
    }
  }

  void _changeLuminosityState(ChangeLuminosityStateEvent event, Emitter<MapState> emit) async {
    if (state.hasLuminosity != event.hasLuminosity) {
      final hasLocationAccess = state.locationAccessStatus.isPermissionGranted;
      if (event.hasLuminosity) {
        if (!hasLocationAccess) {
          // await yandexMapController.setMapStyle(getLuminosityStyle(state.zoomLevel.toInt()));
          emit(state.copyWith(hasLuminosity: true));
        }
      } else {
        emit(state.copyWith(hasLuminosity: false));
        if (!hasLocationAccess) {
          await Future.delayed(const Duration(seconds: 10));
          add(const ChangeLuminosityStateEvent(hasLuminosity: true));
        }
      }
    }
  }

  void _cameraMoved(CameraMovedEvent event, Emitter<MapState> emit) async {
    clusterManager.onCameraMove(event.cameraPosition);
    print('position: ${event.cameraPosition.zoom}');
    add(const ChangeLuminosityStateEvent(hasLuminosity: false));
  }

  void _cameraIdled(CameraIdled event, Emitter<MapState> emit) async {
    clusterManager.updateMap();
  }

  void _zoomIn(ZoomInEvent event, Emitter<MapState> emit) {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut(ZoomOutEvent event, Emitter<MapState> emit) {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }

  void _moveMapCamera(double lat, double long, [double? zoom]) async {
    final newPosition = CameraUpdate.newLatLngZoom(LatLng(lat, long), zoom ?? state.zoomLevel);
    await mapController.animateCamera(newPosition);
  }

  bool isLocationInVisibleRegion(double lat, double lng, LatLngBounds bounds) {
    return (lat <= bounds.northeast.latitude && lat >= bounds.southwest.latitude) &&
        (lng <= bounds.northeast.longitude && lng >= bounds.southwest.longitude);
  }

  // Future<PlacemarkMapObject> _getPlaceMarkObject({
  //   required ValueChanged<ChargeLocationEntity> onTap,
  //   required ChargeLocationEntity location,
  //   required bool withLuminosity,
  // }) async {
  //   final point = Point(latitude: double.tryParse(location.latitude) ?? 0.0, longitude: double.tryParse(location.longitude) ?? 0.0);
  //   return PlacemarkMapObject(
  //     opacity: 1,
  //     onTap: (object, point) async {
  //       add(const ChangeLuminosityStateEvent(hasLuminosity: false));
  //       // add(SelectUnSelectMapObject(locationId: location.id));
  //       _moveMapCamera(object.point.latitude, object.point.longitude, 18);
  //       onTap(location);
  //     },
  //     icon: getIcon(Uint8List.fromList(StorageRepository.getString('${StorageKeys.locationAppearance}_${location.id}').codeUnits)),
  //     mapId: MapObjectId('location_${location.id}'),
  //     point: point,
  //   );
  // }
  //
  // ClusterizedPlacemarkCollection _getClusterObject({required List<PlacemarkMapObject> placemarks, required bool withLuminosity}) {
  //   return ClusterizedPlacemarkCollection(
  //     mapId: const MapObjectId('cluster'),
  //     radius: 30,
  //     minZoom: 18,
  //     placemarks: placemarks,
  //     onClusterAdded: (self, cluster) async {
  //       final appearance = await _getClusterAppearance(placeCount: cluster.placemarks.length, withLuminosity: withLuminosity);
  //       return cluster.copyWith(appearance: cluster.appearance.copyWith(opacity: 1, icon: getIcon(appearance, const Offset(0.5, 0.5))));
  //     },
  //     onClusterTap: (self, cluster) async {
  //       add(const ChangeLuminosityStateEvent(hasLuminosity: false));
  //       final placemarks = cluster.placemarks;
  //       final point = _getAveragePointOfClusterPlacemarks(placemarks);
  //       final distance = _getDistanceBetweenClusterPlacemarks(placemarks);
  //       final neededZoom = _determineZoomLevel(distance).toDouble();
  //       _moveMapCamera(point.latitude, point.longitude, neededZoom);
  //     },
  //   );
  // }

  Future<Uint8List> _getLocationAppearance({
    required List<ConnectorStatus> stationStatuses,
    required String logo,
    bool isSelected = false,
    bool withLuminosity = false,
  }) async {
    if (logo.isNotEmpty) {
      await precacheImage(CachedNetworkImageProvider(logo), context);
    }
    final image = await MyFunctions.createImageFromWidget(
      LocationPinWidget(
        logo: logo,
        statuses: stationStatuses,
        adjustSaturation: withLuminosity,
        isSelected: isSelected,
      ),
    );
    return image!;
  }

  Future<Uint8List> _getClusterAppearance({required int placeCount, required bool withLuminosity}) async {
    return await MyFunctions.getBytesFromCanvas(
      width: 150,
      height: 150,
      placeCount: placeCount,
      context: context,
      image: withLuminosity ? AppImages.clusterMarkWithLuminosity : AppImages.clusterMark,
      shouldAddText: true,
      shouldAddShadow: false,
    );
  }

  LatLng _getAveragePointOfClusterPlacemarks(List<MyClusterItem> placemarks) {
    double averageLatitude = placemarks.map((e) => e.position.latitude).reduce((a, b) => a + b) / placemarks.length;
    double averageLongitude = placemarks.map((e) => e.position.longitude).reduce((a, b) => a + b) / placemarks.length;
    return LatLng(averageLatitude, averageLongitude);
  }

  double _getDistanceBetweenClusterPlacemarks(List<MyClusterItem> placemarks) {
    double maxDistance = 0;
    for (int i = 0; i < placemarks.length; i++) {
      for (int j = i + 1; j < placemarks.length; j++) {
        final firstPoint = placemarks[i].position;
        final secondPoint = placemarks[j].position;
        double distance = MyFunctions.getDistanceBetweenTwoPoints(firstPoint, secondPoint);
        if (distance > maxDistance) {
          maxDistance = distance;
        }
      }
    }
    return maxDistance;
  }

  int _determineZoomLevel(double distance, {double minZoom = 4, double maxZoom = 18}) {
    const double scale = 246;
    const double base = 2;
    double zoomLevel = maxZoom - log(distance / scale) / log(base);
    return zoomLevel.toInt();
  }

  bool _canGet(double zoom, LatLng target) {
    double oldLat = state.cameraPosition.latitude;
    double oldLong = state.cameraPosition.latitude;
    double newLat = target.latitude;
    double newLong = target.longitude;
    double distanceInterval = 0.0;
    double radius = MyFunctions.getRadiusFromZoom(zoom);
    distanceInterval = (radius * 1000) * .5;
    final distanceTraveled = MyFunctions.getDistanceBetweenTwoPoints(LatLng(oldLat, oldLong), LatLng(newLat, newLong));
    if (distanceTraveled > distanceInterval || state.zoomLevel <= (zoom - 1)) {
      return true;
    }
    return false;
  }

  Future<bool> isSamePosition(LatLng position) async {
    final visibleRegion = await mapController.getVisibleRegion();
    final center = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) / 2,
    );
    final zoomLevel = await mapController.getZoomLevel();
    final isSameLat = center.latitude.toStringAsFixed(6) == position.latitude.toStringAsFixed(6);
    final isSameLong = center.longitude.toStringAsFixed(6) == position.longitude.toStringAsFixed(6);
    final isSameZoom = zoomLevel == 16;
    return isSameLat && isSameLong && isSameZoom;
  }
}
