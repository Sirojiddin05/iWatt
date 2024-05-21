import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/list/domain/usecases/get_charge_locations_usecase.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unsave_stream_usecase.dart';
import 'package:rxdart/transformers.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'charge_locations_event.dart';
part 'charge_locations_state.dart';

class ChargeLocationsBloc extends Bloc<ChargeLocationsEvent, ChargeLocationsState> {
  final GetChargeLocationsUseCase getChargeLocationsUseCase;
  final SaveUnSaveStreamUseCase saveStreamUseCase;
  late final StreamSubscription<ChargeLocationEntity> chargeLocationSaveSubscription;

  ChargeLocationsBloc({
    required this.getChargeLocationsUseCase,
    required this.saveStreamUseCase,
  }) : super(const ChargeLocationsState()) {
    chargeLocationSaveSubscription = saveStreamUseCase.call(NoParams()).listen((location) {
      if (!isClosed) {
        add(ChangeSavedStateOfLocation(location: location));
      }
    });
    on<GetChargeLocationsEvent>(_getLocations, transformer: debounce(const Duration(milliseconds: 300)));
    on<GetMoreChargeLocationsEvent>(_getMoreLocations);
    on<SetSearchPatternEvent>(_setSearchPattern);
    on<SetFilterEvent>(_setFilter);
    on<ChangeSavedStateOfLocation>(_setSavedState);
    on<SetPointEvent>(_setPoint);
  }

  void _getLocations(GetChargeLocationsEvent event, Emitter<ChargeLocationsState> emit) async {
    emit(state.copyWith(getChargeLocationsStatus: FormzSubmissionStatus.inProgress));
    final longitude = state.longitude == -1 ? StorageRepository.getDouble(StorageKeys.longitude) : state.longitude;
    final latitude = state.longitude == -1 ? StorageRepository.getDouble(StorageKeys.latitude) : state.latitude;
    final result = await getChargeLocationsUseCase.call(
      GetChargeLocationParamEntity(
        powerType: state.selectedPowerTypes,
        connectorType: state.selectedConnectorTypes,
        searchPattern: state.searchPattern,
        longitude: longitude,
        latitude: latitude,
        isFavourite: state.isFavourite,
        zoom: state.zoom,
      ),
    );
    if (result.isRight) {
      emit(state.copyWith(
        getChargeLocationsStatus: FormzSubmissionStatus.success,
        chargeLocations: result.right.results,
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
    emit(state.copyWith(selectedConnectorTypes: event.connectorTypes, selectedPowerTypes: event.powerTypes));
    add(const GetChargeLocationsEvent());
  }

  void _setPoint(SetPointEvent event, Emitter<ChargeLocationsState> emit) {
    final distance = MyFunctions.getDistanceBetweenTwoPoints(event.point, Point(latitude: state.latitude, longitude: state.longitude));
    if (distance > 10) {
      emit(state.copyWith(zoom: event.zoom, latitude: event.point.latitude, longitude: event.point.longitude));
      add(const GetChargeLocationsEvent());
    }
  }

  void _setSavedState(ChangeSavedStateOfLocation event, Emitter<ChargeLocationsState> emit) {
    final oldList = state.chargeLocations;
    for (int i = 0; i < oldList.length; i++) {
      final location = oldList[i];
      if (location.id == event.location.id) {
        oldList[i] = oldList[i].copyWith(isFavorite: event.location.isFavorite);
        final newList = [...oldList];
        emit(state.copyWith(chargeLocations: newList));
        break;
      }
    }
  }

  EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) => (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
