import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/get_locations_from_local_params.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_locations_from_local_source_usecase.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_map_locations_usecase.dart';
import 'package:i_watt_app/features/map/domain/usecases/save_location_list_usecase.dart';
import 'package:i_watt_app/features/map/presentation/widgets/location_pin_widget.dart';

part 'map_locations_event.dart';
part 'map_locations_state.dart';

class MapLocationsBloc extends Bloc<MapLocationsEvent, MapLocationsState> {
  final GetLocationsFromLocalSourceUseCase getLocationsFromLocalSourceUseCase;
  final GetMapLocationsUseCase getLocationsUseCase;
  final SaveLocationListUseCase saveLocationListUseCase;
  final BuildContext context;

  MapLocationsBloc(
    this.getLocationsFromLocalSourceUseCase,
    this.getLocationsUseCase,
    this.saveLocationListUseCase,
    this.context,
  ) : super(const MapLocationsState()) {
    on<GetLocationsFromLocal>(_getLocationsFromLocal);
    on<GeAllLocationsFromRemoteEvent>(_getAllLocationsFromRemote);
    on<SetVisibleRegionBounds>(_setVisibleRegionBounds);
    on<SetFilterForMapLocationsEvent>(_setFilterForMapLocations);
    on<GetFilteredLocations>(_getFilteredLocations);
    // final areLocationsFetchedBefore = StorageRepository.getBool(StorageKeys.areLocationsFetched, defValue: false);
    // if (!areLocationsFetchedBefore) {
    add(const GeAllLocationsFromRemoteEvent());
    // }
  }

  void _getLocationsFromLocal(GetLocationsFromLocal event, Emitter<MapLocationsState> emit) async {
    final result = await getLocationsFromLocalSourceUseCase.call(
      GetLocationsFromLocalParams(
        southWestLongitude: state.southWestLongitude,
        southWestLatitude: state.southWestLatitude,
        northEastLongitude: state.northEastLongitude,
        northEastLatitude: state.northEastLatitude,
        locationIds: state.filteredLocationIds,
      ),
    );
    if (result.isRight) {
      emit(state.copyWith(
        getChargeLocationsStatus: FormzSubmissionStatus.success,
        chargeLocations: [...result.right],
      ));
    } else {
      emit(state.copyWith(
        getChargeLocationsStatus: FormzSubmissionStatus.failure,
      ));
    }
  }

  void _getAllLocationsFromRemote(GeAllLocationsFromRemoteEvent event, Emitter<MapLocationsState> emit) async {
    emit(state.copyWith(getLocationsFromRemoteStatus: FormzSubmissionStatus.inProgress));
    final result = await getLocationsUseCase.call(const GetChargeLocationParamEntity());
    if (result.isRight) {
      final locationList = [...result.right];
      for (int i = 0; i < locationList.length; i++) {
        final locationAppearance = await _getLocationAppearance(
          logo: locationList[i].logo,
          stationStatuses: List<ConnectorStatus>.generate(
            locationList[i].connectorsStatus.length,
            (index) => ConnectorStatus.fromString(locationList[i].connectorsStatus[index]),
          ),
        );
        locationList[i] = locationList[i].copyWith(
          locationAppearance: base64Encode(locationAppearance),
        );
      }
      final saved = await saveLocations(locationList);
      if (saved) {
        emit(state.copyWith(getLocationsFromRemoteStatus: FormzSubmissionStatus.success));
      }
    }
  }

  void _setVisibleRegionBounds(SetVisibleRegionBounds event, Emitter<MapLocationsState> emit) {
    emit(
      state.copyWith(
        northEastLatitude: event.bounds.northeast.latitude,
        northEastLongitude: event.bounds.northeast.longitude,
        southWestLatitude: event.bounds.southwest.latitude,
        southWestLongitude: event.bounds.southwest.longitude,
      ),
    );
    add(GetLocationsFromLocal());
  }

  void _setFilterForMapLocations(SetFilterForMapLocationsEvent event, Emitter<MapLocationsState> emit) {
    emit(state.copyWith(
      selectedConnectorTypes: event.connectorTypes,
      selectedPowerTypes: event.powerTypes,
      selectedVendors: event.vendors,
      selectedStatuses: event.locationStatuses,
      integrated: event.integrated,
    ));
    add(const GetFilteredLocations());
  }

  void _getFilteredLocations(GetFilteredLocations event, Emitter<MapLocationsState> emit) async {
    emit(state.copyWith(getChargeLocationsStatus: FormzSubmissionStatus.inProgress));
    final result = await getLocationsUseCase.call(GetChargeLocationParamEntity(
      integrated: state.integrated,
      connectorType: state.selectedConnectorTypes,
      powerType: state.selectedPowerTypes,
      vendors: List<int>.generate(
        state.selectedVendors.length,
        (index) => state.selectedVendors[index].id,
      ),
      locationStatuses: state.selectedStatuses,
    ));
    if (result.isRight) {
      emit(
        state.copyWith(
          filteredLocationIds: List<int>.generate(
            result.right.length,
            (index) => result.right[index].id,
          ),
        ),
      );
      add(GetLocationsFromLocal());
    } else {
      emit(state.copyWith(getChargeLocationsStatus: FormzSubmissionStatus.failure));
    }
  }

  Future<bool> saveLocations(List<ChargeLocationEntity> locations) async {
    final result = await saveLocationListUseCase.call(locations);
    if (result.isRight) {
      await StorageRepository.putBool(key: StorageKeys.areLocationsFetched, value: true);
    } else {
      await StorageRepository.putBool(key: StorageKeys.areLocationsFetched, value: false);
    }
    return result.isRight;
  }

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

  bool _canGet(double zoom, LatLng target) {
    double oldLat = state.cameraPosition!.target.latitude;
    double oldLong = state.cameraPosition!.target.longitude;
    double newLat = target.latitude;
    double newLong = target.longitude;
    double distanceInterval = 0.0;
    double radius = MyFunctions.getRadiusFromZoom(zoom);
    distanceInterval = (radius * 1000) * .5;
    final distanceTraveled = MyFunctions.getDistanceBetweenTwoPoints(LatLng(oldLat, oldLong), LatLng(newLat, newLong));
    if (distanceTraveled > distanceInterval || state.cameraPosition!.zoom <= (zoom - 1)) {
      return true;
    }
    return false;
  }
}
