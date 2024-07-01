import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/list/domain/usecases/get_charge_locations_usecase.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unsave_stream_usecase.dart';
import 'package:rxdart/transformers.dart';

part 'charge_locations_event.dart';
part 'charge_locations_state.dart';

class ChargeLocationsBloc extends Bloc<ChargeLocationsEvent, ChargeLocationsState> {
  final GetChargeLocationsUseCase getChargeLocationsUseCase;
  final SaveUnSaveStreamUseCase saveStreamUseCase;
  final bool isForMap;
  late final StreamSubscription<ChargeLocationEntity> chargeLocationSaveSubscription;

  ChargeLocationsBloc({
    required this.getChargeLocationsUseCase,
    required this.saveStreamUseCase,
    this.isForMap = false,
  }) : super(ChargeLocationsState(isForMap: isForMap)) {
    chargeLocationSaveSubscription = saveStreamUseCase.call(NoParams()).listen((location) {
      if (!isClosed) {
        add(ChangeSavedStateOfLocation(location: location));
      }
    });
    on<GetChargeLocationsEvent>(_getLocations, transformer: debounce(const Duration(milliseconds: 300)));
    on<GetMoreChargeLocationsEvent>(_getMoreLocations);
    on<SetSearchPatternEvent>(_setSearchPattern);
    on<SetFilterEvent>(_setFilter);
    on<ChangeSavedStateOfLocation>(_setSavedState, transformer: droppable());
    on<SetFavouriteEvent>(_setFavouriteEvent);
  }

  void _getLocations(GetChargeLocationsEvent event, Emitter<ChargeLocationsState> emit) async {
    emit(state.copyWith(getChargeLocationsStatus: FormzSubmissionStatus.inProgress));
    final longitude = state.longitude == -1 ? StorageRepository.getDouble(StorageKeys.longitude) : state.longitude;
    final latitude = state.longitude == -1 ? StorageRepository.getDouble(StorageKeys.latitude) : state.latitude;
    final vendors = List<int>.generate(
      state.selectedVendors.length,
      (index) => state.selectedVendors[index].id,
    );
    final radius = state.zoom != -1 ? MyFunctions.getRadiusFromZoom(state.zoom) : -1.0;
    final result = await getChargeLocationsUseCase.call(
      GetChargeLocationParamEntity(
        powerType: state.selectedPowerTypes,
        connectorType: state.selectedConnectorTypes,
        vendors: vendors.contains(0) ? [] : vendors,
        searchPattern: state.searchPattern,
        longitude: longitude,
        latitude: latitude,
        isFavourite: state.isFavourite,
        radius: radius,
      ),
    );
    if (result.isRight) {
      emit(state.copyWith(
        getChargeLocationsStatus: FormzSubmissionStatus.success,
        chargeLocations: [...result.right.results],
        fetchMore: result.right.next?.isNotEmpty ?? false,
        next: result.right.next ?? '',
      ));
    } else {
      emit(state.copyWith(getChargeLocationsStatus: FormzSubmissionStatus.failure));
    }
  }

  void _getMoreLocations(GetMoreChargeLocationsEvent event, Emitter<ChargeLocationsState> emit) async {
    final result = await getChargeLocationsUseCase.call(
      GetChargeLocationParamEntity(
        powerType: state.selectedPowerTypes,
        connectorType: state.selectedConnectorTypes,
        searchPattern: state.searchPattern,
        next: state.next,
      ),
    );
    if (result.isRight) {
      final oldList = state.chargeLocations;
      final newList = result.right.results;
      final next = result.right.next;
      emit(state.copyWith(
        chargeLocations: [...oldList, ...newList],
        next: next,
        fetchMore: next != null && next.isNotEmpty,
      ));
    } else {
      emit(state.copyWith(fetchMore: false, next: ''));
    }
  }

  void _setSearchPattern(SetSearchPatternEvent event, Emitter<ChargeLocationsState> emit) {
    emit(state.copyWith(searchPattern: event.pattern));
    if (event.pattern.isNotEmpty) {
      add(const GetChargeLocationsEvent());
    }
  }

  void _setFilter(SetFilterEvent event, Emitter<ChargeLocationsState> emit) {
    emit(state.copyWith(
      selectedConnectorTypes: event.connectorTypes,
      selectedPowerTypes: event.powerTypes,
      selectedVendors: event.vendors,
    ));
    add(const GetChargeLocationsEvent());
  }

  void _setFavouriteEvent(SetFavouriteEvent event, Emitter<ChargeLocationsState> emit) {
    emit(state.copyWith(isFavourite: event.isFavourite));
    add(const GetChargeLocationsEvent());
  }

  void _setSavedState(ChangeSavedStateOfLocation event, Emitter<ChargeLocationsState> emit) {
    final oldList = [...state.chargeLocations];
    for (int i = 0; i < oldList.length; i++) {
      final location = oldList[i];
      if (location.id == event.location.id) {
        if (state.isFavourite && !event.location.isFavorite) {
          oldList.removeAt(i);
        } else {
          oldList[i] = oldList[i].copyWith(isFavorite: event.location.isFavorite);
        }
        final newList = [...oldList];
        emit(state.copyWith(chargeLocations: [...newList]));
        break;
      }
    }
  }

  EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) => (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
