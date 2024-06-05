import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';
import 'package:meta/meta.dart';

part 'edit_car_event.dart';
part 'edit_car_state.dart';

class EditCarBloc extends Bloc<EditCarEvent, EditCarState> {
  EditCarBloc() : super(const EditCarState()) {
    on<EditCarEvent>((event, emit) {});
  }
}
