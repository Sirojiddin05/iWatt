part of 'charge_location_single_bloc.dart';

abstract class ChargeLocationSingleEvent {
  const ChargeLocationSingleEvent();
}

class GetLocationSingle extends ChargeLocationSingleEvent {
  final int id;
  const GetLocationSingle(this.id);
}
