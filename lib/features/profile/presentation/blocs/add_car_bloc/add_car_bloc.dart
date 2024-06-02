import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
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
    on<SetOtherModel>(_setOtherModel);
    on<SetOtherMark>(_setOtherMark);
    on<SetConnectorTypes>(_setConnectorTypes);
    on<SetTemporaryConnectorTypes>(_setTemporaryConnectorTypes);
    on<SetCarNumber>(_setCarNumber);
    on<AddCar>(_addCar);
  }

  void _switchStep(SwitchToStep event, Emitter<AddCarState> emit) {
    emit(state.copyWith(currentStep: event.step));
  }

  void _switchToNextStep(SwitchToNextStep event, Emitter<AddCarState> emit) {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void _switchToPreviousStep(SwitchToPreviousStep event, Emitter<AddCarState> emit) {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void _setManufacturer(SetManufacturer event, Emitter<AddCarState> emit) {
    late final IdNameEntity temporaryModel;
    if (event.manufacturer.name == state.car.manufacturer) {
      temporaryModel = state.temporaryModel;
    } else if (event.manufacturer.id == 0) {
      temporaryModel = const IdNameEntity(id: 0, name: '');
    } else if (event.manufacturer.name != state.car.manufacturer) {
      temporaryModel = const IdNameEntity(id: -1, name: '');
    }
    final car = state.car.copyWith(manufacturer: event.manufacturer.name);
    emit(state.copyWith(car: car, temporaryModel: temporaryModel, temporaryManufacturer: event.manufacturer));
    add(SwitchToNextStep());
  }

  void _setTemporaryModel(SetTemporaryModel event, Emitter<AddCarState> emit) {
    emit(state.copyWith(temporaryModel: event.model));
  }

  void _setOtherModel(SetOtherModel event, Emitter<AddCarState> emit) {
    emit(state.copyWith(otherModel: event.model));
  }

  void _setOtherMark(SetOtherMark event, Emitter<AddCarState> emit) {
    emit(state.copyWith(otherMark: event.mark));
  }

  void _setModel(SetModel event, Emitter<AddCarState> emit) {
    final name = state.temporaryModel.id == 0 ? state.otherModel : state.temporaryModel.name;
    final car = state.car.copyWith(model: name);
    emit(state.copyWith(car: car));
    add(SwitchToNextStep());
  }

  void _setTemporaryConnectorTypes(SetTemporaryConnectorTypes event, Emitter<AddCarState> emit) {
    emit(state.copyWith(temporaryConnectorTypes: [...event.ids]));
  }

  void _setConnectorTypes(SetConnectorTypes event, Emitter<AddCarState> emit) {
    final car = state.car.copyWith(
      connectorType: state.temporaryConnectorTypes.map((e) => IdNameEntity(id: e)).toList(),
    );
    emit(state.copyWith(car: car));
    add(SwitchToNextStep());
  }

  void _setCarNumber(SetCarNumber event, Emitter<AddCarState> emit) {
    final number = event.number;
    final numberType = MyFunctions.getCarNumberType(MyFunctions.carNumberType(number));
    final car = state.car.copyWith(stateNumber: event.number, stateNumberType: numberType);
    emit(state.copyWith(car: car));
  }

  Future<void> _addCar(AddCar event, Emitter<AddCarState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final car = state.car.copyWith(
      manufacturer: state.temporaryManufacturer.id == 0 ? state.otherMark : null,
    );
    try {
      final result = await addCarUseCase.call(car);
      if (result.isRight) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          error: result.left.errorMessage,
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}
