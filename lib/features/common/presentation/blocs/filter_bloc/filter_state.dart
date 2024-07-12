part of 'filter_bloc.dart';

class FilterState extends Equatable {
  const FilterState({
    this.integrated = false,
    this.connectorTypes = const [],
    this.powerTypes = const [],
    this.statuses = const [],
    this.allVendors = const [],
    this.vendors = const [],
    this.temporaryVendors = const [],
    this.page = 0,
  });

  final List<int> connectorTypes;
  final List<int> powerTypes;
  final List<String> statuses;
  final List<IdNameEntity> allVendors;
  final List<IdNameEntity> vendors;
  final List<IdNameEntity> temporaryVendors;
  final bool integrated;
  final int page;

  FilterState copyWith({
    bool? integrated,
    List<int>? connectorTypes,
    List<int>? powerTypes,
    List<String>? statuses,
    List<IdNameEntity>? vendors,
    List<IdNameEntity>? allVendors,
    List<IdNameEntity>? temporaryVendors,
    int? page,
  }) {
    return FilterState(
      integrated: integrated ?? this.integrated,
      connectorTypes: connectorTypes ?? this.connectorTypes,
      powerTypes: powerTypes ?? this.powerTypes,
      statuses: statuses ?? this.statuses,
      allVendors: allVendors ?? this.allVendors,
      vendors: vendors ?? this.vendors,
      temporaryVendors: temporaryVendors ?? this.temporaryVendors,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [
        integrated,
        connectorTypes,
        powerTypes,
        statuses,
        vendors,
        temporaryVendors,
        page,
        allVendors,
      ];
}
