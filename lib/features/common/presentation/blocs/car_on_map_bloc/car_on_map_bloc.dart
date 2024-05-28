import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/enums/car_on_map.dart';

part 'car_on_map_event.dart';
part 'car_on_map_state.dart';

class CarOnMapBloc extends Bloc<CarOnMapEvent, CarOnMapState> {
  CarOnMapBloc() : super(CarOnMapState(CarOnMap.defineType(StorageRepository.getString(StorageKeys.carOnMap)))) {
    on<CarOnMapChanged>((event, emit) async {
      await StorageRepository.putString(StorageKeys.carOnMap, event.carOnMap.title);
      emit(CarOnMapState(event.carOnMap));
    });
  }
}
