import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'charge_location_single_event.dart';
part 'charge_location_single_state.dart';

class ChargeLocationSingleBloc extends Bloc<ChargeLocationSingleEvent, ChargeLocationSingleState> {
  ChargeLocationSingleBloc() : super(const ChargeLocationSingleState()) {
    on<ChargeLocationSingleEvent>((event, emit) {});
  }
}
