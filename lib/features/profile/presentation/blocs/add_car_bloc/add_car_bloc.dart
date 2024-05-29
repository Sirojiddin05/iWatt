import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';
import 'package:i_watt_app/features/profile/domain/usecases/add_car_usecase.dart';
import 'package:meta/meta.dart';

part 'add_car_event.dart';
part 'add_car_state.dart';

class AddCarBloc extends Bloc<AddCarEvent, AddCarState> {
  final AddCarUseCase addCarUseCase;
  AddCarBloc(this.addCarUseCase) : super(const AddCarState()) {
    on<SwitchToStep>(_switchStep);
    on<SwitchToNextStep>(_switchToNextStep);
    on<SwitchToPreviousStep>(_switchToPreviousStep);
    on<SetManufacturer>(_setManufacturer);
    on<SetModel>(_setModel);
    on<SetTemporaryModel>(_setTemporaryModel);
    on<SetConnectorTypes>(_setConnectorTypes);
    on<SetTemporaryConnectorTypes>(_setTemporaryConnectorTypes);
    on<SetCustomManufacturer>(_setCustomManufacturer);
    on<SetCustomModel>(_setCustomModel);
    on<SetCarNumber>(_setCarNumber);
    on<AddCar>(_addCar);
  }

  void _switchStep(SwitchToStep event, Emitter<AddCarState> emit) {
    emit(state.copyWith(currentStep: event.step));
  }

  void _switchToNextStep(SwitchToNextStep event, Emitter<AddCarState> emit) {
    print('_switchToNextStep');
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void _switchToPreviousStep(SwitchToPreviousStep event, Emitter<AddCarState> emit) {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void _setManufacturer(SetManufacturer event, Emitter<AddCarState> emit) {
    late final int temporaryModel;
    if (event.id == 0) {
      temporaryModel = 0;
    } else if (event.id != state.car.manufacturer) {
      temporaryModel = -1;
    } else {
      temporaryModel = state.temporaryModel;
    }
    final car = state.car.copyWith(manufacturer: event.id);
    emit(state.copyWith(car: car, temporaryModel: temporaryModel));
    add(SwitchToNextStep());
  }

  void _setTemporaryModel(SetTemporaryModel event, Emitter<AddCarState> emit) {
    emit(state.copyWith(temporaryModel: event.id));
  }

  void _setModel(SetModel event, Emitter<AddCarState> emit) {
    final car = state.car.copyWith(model: state.temporaryModel);
    emit(state.copyWith(car: car));
    add(SwitchToNextStep());
  }

  void _setTemporaryConnectorTypes(SetTemporaryConnectorTypes event, Emitter<AddCarState> emit) {
    emit(state.copyWith(temporaryConnectorTypes: [...event.ids]));
  }

  void _setConnectorTypes(SetConnectorTypes event, Emitter<AddCarState> emit) {
    final car = state.car.copyWith(chargingType: state.temporaryConnectorTypes);
    emit(state.copyWith(car: car));
    add(SwitchToNextStep());
  }

  void _setCustomManufacturer(SetCustomManufacturer event, Emitter<AddCarState> emit) {
    final car = state.car.copyWith(customManufacturer: event.manufacturer);
    emit(state.copyWith(car: car));
  }

  void _setCustomModel(SetCustomModel event, Emitter<AddCarState> emit) {
    final car = state.car.copyWith(customModel: event.model);
    emit(state.copyWith(car: car));
  }

  void _setCarNumber(SetCarNumber event, Emitter<AddCarState> emit) {
    final number = event.number;
    final numberType = MyFunctions.carNumberType(number);
    final car = state.car.copyWith(stateNumber: event.number, typeStateNumber: numberType);
    emit(state.copyWith(car: car));
  }

  Future<void> _addCar(AddCar event, Emitter<AddCarState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await addCarUseCase(state.car);
    if (result.isRight) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        error: result.left.errorMessage,
      ));
    }
  }
}
