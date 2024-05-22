import 'dart:async';
import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/core/util/enums/location_permission_status.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late final YandexMapController yandexMapController;
  late final BuildContext context;

  MapBloc() : super(const MapState()) {
    on<SetChargeLocations>(_setChargeLocations);
    on<RequestLocationAccess>(_requestLocationAccess);
    on<CheckIfSettingsTriggered>(_checkIfSettingsTriggered);
    on<SetLocationAccessStateEvent>(_setLocationAccessState);
    on<SetMyPositionEvent>(_setMyPosition, transformer: droppable());
    on<InitializeMapControllerEvent>(_initializeController);
    on<ChangeZoomEvent>(_changeZoom, transformer: droppable());
    on<SaveZoomOnCameraPositionChanged>(_saveZoomOnCameraPositionChanged);
    on<DrawChargeLocationsEvent>(_drawChargeLocation);
    on<TapMapObjectEvent>(_tapObject);
    on<ChangeLuminosityStateEvent>(_changeLuminosityState);
    on<SetControllersVisibilityEvent>(_setControllersVisibility);
    on<SetDraggableSheetOffsetEvent>(_setDraggableSheetOffset);
  }

  void _initializeController(InitializeMapControllerEvent event, Emitter<MapState> emit) async {
    print('initializing controller');
    yandexMapController = event.mapController;
    final lastLat = StorageRepository.getDouble('current_lat', defValue: -1);
    final lastLong = StorageRepository.getDouble('current_long', defValue: -1);
    if (lastLat != -1 && lastLong != -1) await _moveMapCamera(lastLat, lastLong);
    context = event.context;
    emit(state.copyWith(isMapInitialized: true));
    await Future.delayed(const Duration(seconds: 1));
    add(const SetControllersVisibilityEvent(areControllersVisible: true));
  }

  void _setMyPosition(SetMyPositionEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(userLocationAccessingStatus: FormzSubmissionStatus.inProgress));
    final locationStatus = await MyFunctions.getWhetherPermissionGranted();
    if (locationStatus.isPermissionGranted) {
      final value = await MyFunctions.getCurrentLocation();
      if (value != null) {
        if (value.latitude != state.currentLat || value.longitude != state.currentLong) {
          await StorageRepository.putDouble(StorageKeys.latitude, value.latitude);
          await StorageRepository.putDouble(StorageKeys.longitude, value.longitude);
          final newMarker = await MyFunctions.getMyIcon(
            context: context,
            value: value,
            onObjectTap: (object, point) async => await _moveMapCamera(object.point.latitude, object.point.longitude, 18),
          );
          emit(state.copyWith(
            userLocationObject: newMarker,
            userLocationAccessingStatus: FormzSubmissionStatus.success,
            currentLat: value.latitude,
            currentLong: value.longitude,
            locationAccessStatus: LocationPermissionStatus.permissionGranted,
          ));
        } else {
          emit(state.copyWith(userLocationAccessingStatus: FormzSubmissionStatus.success));
        }
        await _moveMapCamera(value.latitude, value.longitude, 18);
      }
    } else {
      add(SetLocationAccessStateEvent(status: locationStatus));
    }
  }

  void _setChargeLocations(SetChargeLocations event, Emitter<MapState> emit) {
    emit(state.copyWith(chargeLocations: event.locations));
  }

  void _setLocationAccessState(SetLocationAccessStateEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(
      userLocationAccessingStatus: FormzSubmissionStatus.failure,
      locationAccessStatus: event.status,
    ));
  }

  void _changeZoom(ChangeZoomEvent event, Emitter<MapState> emit) async {
    yandexMapController.moveCamera(event.cameraUpdate, animation: const MapAnimation(duration: 0.3, type: MapAnimationType.smooth));
  }

  void _saveZoomOnCameraPositionChanged(SaveZoomOnCameraPositionChanged event, Emitter<MapState> emit) {
    emit(state.copyWith(zoomLevel: event.zoom));
  }

  void _drawChargeLocation(DrawChargeLocationsEvent event, Emitter<MapState> emit) async {
    final List<PlacemarkMapObject> placeMarks = [];
    for (final location in event.locations) {
      final newObject = await _getPlaceMarkObject(onTap: event.onLocationTap, location: location, withLuminosity: event.withLuminosity);
      placeMarks.add(newObject);
    }
    final clusterObject = _getClusterObject(placemarks: placeMarks, withLuminosity: event.withLuminosity);
    emit(state.copyWith(chargeLocationsObjects: clusterObject));
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

  void _tapObject(TapMapObjectEvent event, Emitter<MapState> emit) async {
    final oldPLaceMarks = [...state.locationsMapObjects!.placemarks];
    for (int i = 0; i < oldPLaceMarks.length; i++) {
      final mapObject = oldPLaceMarks[i];
      if (mapObject.mapId == event.object.mapId) {
        final newAppearance = await _getLocationAppearance(stationStatuses: event.connectorStatuses, isSelected: true);
        oldPLaceMarks[i] = event.object.copyWith(icon: getIcon(newAppearance));
        final oldCluster = state.locationsMapObjects!;
        final newMapObjects = oldCluster.copyWith(placemarks: [...oldPLaceMarks]);
        emit(state.copyWith(chargeLocationsObjects: newMapObjects));
        break;
      }
    }
  }

  void _changeLuminosityState(ChangeLuminosityStateEvent event, Emitter<MapState> emit) async {
    if (event.hasLuminosity) {
      if (!state.isMapTappedAlready) {
        await yandexMapController.setMapStyle(getLuminosityStyle(state.zoomLevel.toInt()));
        emit(state.copyWith(hasLuminosity: true, isMapTappedAlready: true));
      }
    } else {
      // if (!state.hasLuminosity) {
      await yandexMapController.setMapStyle('');
      emit(state.copyWith(hasLuminosity: false));
      //   await Future.delayed(const Duration(seconds: 10));
      //   await yandexMapController.setMapStyle(getLuminosityStyle(state.zoomLevel.toInt()));
      //   emit(state.copyWith(hasLuminosity: true, isMapTappedAlready: true));
      // }
    }
  }

  void _setControllersVisibility(SetControllersVisibilityEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(
      areControllersVisible: event.areControllersVisible,
      isSearchFieldVisible: event.searchFieldVisible,
    ));
  }

  void _setDraggableSheetOffset(SetDraggableSheetOffsetEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(draggableSheetOffset: event.offset));
  }

  Future<void> _moveMapCamera(double lat, double long, [double? zoom]) async {
    final target = Point(latitude: lat, longitude: long);
    const animation = MapAnimation(type: MapAnimationType.linear, duration: 0.5);
    final newPosition = CameraPosition(target: target, zoom: zoom ?? state.zoomLevel);
    await yandexMapController.moveCamera(CameraUpdate.newCameraPosition(newPosition), animation: animation);
  }

  Future<PlacemarkMapObject> _getPlaceMarkObject(
      {required ValueChanged<ChargeLocationEntity> onTap, required ChargeLocationEntity location, required bool withLuminosity}) async {
    final point = Point(latitude: double.tryParse(location.latitude) ?? 0.0, longitude: double.tryParse(location.longitude) ?? 0.0);
    final statuses = MyFunctions.getConnectorStatuses(location);
    final locationAppearance = await _getLocationAppearance(stationStatuses: statuses, withLuminosity: withLuminosity);
    return PlacemarkMapObject(
      opacity: 1,
      onTap: (object, point) async {
        add(TapMapObjectEvent(object: object, connectorStatuses: statuses));
        add(const ChangeLuminosityStateEvent(hasLuminosity: false));
        await _moveMapCamera(object.point.latitude, object.point.longitude, 18);
        onTap(location);
      },
      icon: getIcon(locationAppearance),
      mapId: MapObjectId('location_${location.id}'),
      point: point,
    );
  }

  ClusterizedPlacemarkCollection _getClusterObject({required List<PlacemarkMapObject> placemarks, required bool withLuminosity}) {
    return ClusterizedPlacemarkCollection(
      mapId: const MapObjectId('cluster'),
      radius: 15,
      minZoom: 18,
      placemarks: placemarks,
      onClusterAdded: (self, cluster) async {
        final appearance = await _getClusterAppearance(placeCount: cluster.placemarks.length, withLuminosity: withLuminosity);
        return cluster.copyWith(appearance: cluster.appearance.copyWith(opacity: 1, icon: getIcon(appearance, const Offset(0.5, 0.5))));
      },
      onClusterTap: (self, cluster) async {
        add(const ChangeLuminosityStateEvent(hasLuminosity: false));
        final placemarks = cluster.placemarks;
        final point = _getAveragePointOfClusterPlacemarks(placemarks);
        final distance = _getDistanceBetweenClusterPlacemarks(placemarks);
        final neededZoom = _determineZoomLevel(distance).toDouble();
        await _moveMapCamera(point.latitude, point.longitude, neededZoom);
      },
    );
  }

  Future<Uint8List> _getLocationAppearance(
      {required List<ConnectorStatus> stationStatuses, bool isSelected = false, bool withLuminosity = false}) async {
    return await MyFunctions.getBytesFromCanvas(
      width: isSelected ? 176 : 145, //145
      height: isSelected ? 198 : 180, //180
      context: context,
      offset: const Offset(0, 0),
      image: withLuminosity
          ? AppImages.stationSmallWithLuminosity
          : isSelected
              ? AppImages.selectedStationSmall
              : AppImages.stationSmall,
      shouldAddBackCircle: isSelected,
      statuses: stationStatuses,
      withLuminosity: withLuminosity,
    );
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

  PlacemarkIcon getIcon(Uint8List appearance, [Offset anchor = const Offset(0.5, 1)]) {
    return PlacemarkIcon.single(PlacemarkIconStyle(image: BitmapDescriptor.fromBytes(appearance), anchor: anchor));
  }

  Point _getAveragePointOfClusterPlacemarks(List<PlacemarkMapObject> placemarks) {
    double averageLatitude = placemarks.map((e) => e.point.latitude).reduce((a, b) => a + b) / placemarks.length;
    double averageLongitude = placemarks.map((e) => e.point.longitude).reduce((a, b) => a + b) / placemarks.length;
    return Point(latitude: averageLatitude, longitude: averageLongitude);
  }

  double _getDistanceBetweenClusterPlacemarks(List<PlacemarkMapObject> placemarks) {
    double maxDistance = 0;
    for (int i = 0; i < placemarks.length; i++) {
      for (int j = i + 1; j < placemarks.length; j++) {
        final firstPoint = placemarks[i].point;
        final secondPoint = placemarks[j].point;
        double distance = MyFunctions.getDistanceBetweenTwoPoints(firstPoint, secondPoint);
        if (distance > maxDistance) {
          maxDistance = distance;
        }
      }
    }
    return maxDistance;
  }

  int _determineZoomLevel(double distance, {double minZoom = 5, double maxZoom = 15}) {
    const double scale = 1000;
    const double base = 2;
    double zoomLevel = maxZoom - log(distance / scale) / log(base);
    return zoomLevel.toInt();
  }

  String getLuminosityStyle(int zoom) {
    // final minimum = zoom - 1;
    // final maximum = zoom + 1;
    return '''
[
  {
    "stylers": {
      "saturation": -1
    }
  }
]
''';
  }
}
