import 'dart:convert';
import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
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
import 'package:i_watt_app/core/util/enums/car_on_map.dart';
import 'package:i_watt_app/core/util/enums/location_permission_status.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/location_single_sheet.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/cluste_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/cluster_item.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_on_map_sheet.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late final GoogleMapController mapController;
  late final ClusterManager clusterManager;
  late final BuildContext context;
  List<MyClusterItem> clusterItems = [];

  MapBloc() : super(const MapState()) {
    clusterManager = ClusterManager<MyClusterItem>(
      clusterItems,
      (Set<Marker> markers) => add(SetMarkersEvent(markers: markers)),
      clusterAlgorithm: ClusterAlgorithm.MAX_DIST,
      stopClusteringZoom: 18,
      maxDistParams: MaxDistParams(12),
      markerBuilder: (cluster) async {
        late final Uint8List appearance;
        if (cluster.isMultiple) {
          appearance = await _getClusterAppearance(
            placeCount: cluster.items.length,
            withLuminosity: false,
          );
          return Marker(
            markerId: MarkerId('cluster_${cluster.getId()}'),
            position: cluster.location,
            icon: BitmapDescriptor.fromBytes(appearance),
            onTap: () async {
              final point = _getAveragePointOfClusterPlacemarks(cluster.items.toList());
              final distance = _getDistanceBetweenClusterPlacemarks(cluster.items.toList());
              final zoom = _determineZoomLevel(distance).toDouble();
              mapController.animateCamera(CameraUpdate.newLatLngZoom(point, zoom));
            },
          );
        } else {
          return Marker(
            markerId: MarkerId('location_${cluster.items.first.locationEntity.id}'),
            position: cluster.location,
            icon: BitmapDescriptor.fromBytes(base64Decode(cluster.items.first.locationEntity.locationAppearance)),
            onTap: () async {
              _moveMapCamera(cluster.location.latitude, cluster.location.longitude, 18);
              add(const SetLocationSingleOpened(isOpened: true));
              await showLocationSingle(context, cluster.items.first.locationEntity);
              add(const SetLocationSingleOpened(isOpened: false));
              // event.onLocationTap(location);
            },
          );
        }
      },
    );
    on<RequestLocationAccess>(_requestLocationAccess);
    on<CheckIfSettingsTriggered>(_checkIfSettingsTriggered);
    on<SetLocationAccessStateEvent>(_setLocationAccessState);
    on<SetMyPositionEvent>(_setMyPosition, transformer: droppable());
    on<InitializeMapControllerEvent>(_initializeController);
    on<ZoomInEvent>(_zoomIn, transformer: droppable());
    on<ZoomOutEvent>(_zoomOut, transformer: droppable());
    on<ChangeLuminosityStateEvent>(_changeLuminosityState, transformer: droppable());
    on<SetCarOnMapEvent>(_setCarOnMap);
    on<SetPresentPlaceMarks>(_setPresentPlaceMarks);
    on<CameraMovedEvent>(_cameraMoved);
    on<CameraIdled>(_cameraIdled);
    on<SetMarkersEvent>(_setMarkers);
    on<SetLocationSingleOpened>(_setLocationSingleOpened);
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

  void _setLocationAccessState(SetLocationAccessStateEvent event, Emitter<MapState> emit) {
    emit(
      state.copyWith(
        userLocationAccessingStatus: FormzSubmissionStatus.failure,
        locationAccessStatus: event.status,
      ),
    );
  }

  void _setLocationSingleOpened(SetLocationSingleOpened event, Emitter<MapState> emit) {
    emit(state.copyWith(locationSingleOpened: event.isOpened));
  }

  void _setPresentPlaceMarks(SetPresentPlaceMarks event, Emitter<MapState> emit) async {
    final cItems = [...event.locations];
    clusterItems = List<MyClusterItem>.generate(
      cItems.length,
      (index) {
        return MyClusterItem(
          locationEntity: cItems[index],
        );
      },
    );
    clusterManager.setItems(
      clusterItems,
    );
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

  void _moveMapCamera(double lat, double long, double zoom) async {
    final newPosition = CameraUpdate.newLatLngZoom(LatLng(lat, long), zoom);
    await mapController.animateCamera(newPosition);
  }

  void _setMarkers(SetMarkersEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(presentedMapObjects: [...event.markers]));
  }

  // bool isLocationInVisibleRegion(double lat, double lng, LatLngBounds bounds) {
  //   return (lat <= bounds.northeast.latitude && lat >= bounds.southwest.latitude) &&
  //       (lng <= bounds.northeast.longitude && lng >= bounds.southwest.longitude);
  // }

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
    double averageLatitude = placemarks.map((e) => e.location.latitude).reduce((a, b) => a + b) / placemarks.length;
    double averageLongitude = placemarks.map((e) => e.location.longitude).reduce((a, b) => a + b) / placemarks.length;
    return LatLng(averageLatitude, averageLongitude);
  }

  double _getDistanceBetweenClusterPlacemarks(List<MyClusterItem> placemarks) {
    double maxDistance = 0;
    for (int i = 0; i < placemarks.length; i++) {
      for (int j = i + 1; j < placemarks.length; j++) {
        final firstPoint = placemarks[i].location;
        final secondPoint = placemarks[j].location;
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
