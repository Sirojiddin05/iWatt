part of 'charge_locations_bloc.dart';

abstract class ChargeLocationsEvent {
  const ChargeLocationsEvent();
}

class GetChargeLocationsEvent extends ChargeLocationsEvent {
  const GetChargeLocationsEvent();
}

class GetMoreChargeLocationsEvent extends ChargeLocationsEvent {
  const GetMoreChargeLocationsEvent();
}

class GetSingleChargeLocationEvent extends ChargeLocationsEvent {
  final int id;

  const GetSingleChargeLocationEvent(this.id);
}

class SetSearchPatternEvent extends ChargeLocationsEvent {
  final String pattern;
  const SetSearchPatternEvent(this.pattern);
}

class SetFilterEvent extends ChargeLocationsEvent {
  final List<int> connectorTypes;
  final List<int> powerTypes;
  final List<IdNameEntity> vendors;

  const SetFilterEvent({
    required this.connectorTypes,
    required this.powerTypes,
    required this.vendors,
  });
}

class ChangeSavedStateOfLocation extends ChargeLocationsEvent {
  final ChargeLocationEntity location;

  const ChangeSavedStateOfLocation({required this.location});
}

class SetFavouriteEvent extends ChargeLocationsEvent {
  final bool isFavourite;

  const SetFavouriteEvent({required this.isFavourite});
}
