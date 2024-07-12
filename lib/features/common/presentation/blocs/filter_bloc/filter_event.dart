part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent {
  const FilterEvent();
}

class SelectConnectorTypeEvent extends FilterEvent {
  const SelectConnectorTypeEvent({required this.connectorTypes});

  final List<int> connectorTypes;
}

class SelectStatusesEvent extends FilterEvent {
  const SelectStatusesEvent({required this.statuses});

  final List<String> statuses;
}

class SelectPowerTypeEvent extends FilterEvent {
  const SelectPowerTypeEvent({required this.powerType});

  final int powerType;
}

class SwitchIntegratedEvent extends FilterEvent {}

class SelectVendorEvent extends FilterEvent {
  const SelectVendorEvent({required this.vendor});

  final IdNameEntity vendor;
}

class UnSelectVendorEvent extends FilterEvent {
  const UnSelectVendorEvent({required this.vendor});

  final IdNameEntity vendor;
}

class SelectAllVendorsEvent extends FilterEvent {
  const SelectAllVendorsEvent(this.vendors);

  final List<IdNameEntity> vendors;
}

class UnSelectAllVendorsEvent extends FilterEvent {}

class SetPageEvent extends FilterEvent {
  const SetPageEvent({required this.page});

  final int page;
}

class ClearFilterEvent extends FilterEvent {
  const ClearFilterEvent();
}

class SetVendorsEvent extends FilterEvent {
  const SetVendorsEvent();
}

class SetTemporaryVendors extends FilterEvent {
  const SetTemporaryVendors();
}

class ChangeVendorsList extends FilterEvent {
  final List<IdNameEntity> vendors;

  const ChangeVendorsList({required this.vendors});
}
