part of 'filter_bloc.dart';

class FilterState extends Equatable {
  const FilterState({
    this.connectorTypes = const [],
    this.powerTypes = const [],
    this.allVendors = const [],
    this.vendors = const [],
    this.temporaryVendors = const [],
    this.page = 0,
  });

  final List<int> connectorTypes;
  final List<int> powerTypes;
  final List<IdNameEntity> allVendors;
  final List<IdNameEntity> vendors;
  final List<IdNameEntity> temporaryVendors;
  final int page;

  FilterState copyWith({
    List<int>? connectorTypes,
    List<int>? powerTypes,
    List<IdNameEntity>? vendors,
    List<IdNameEntity>? allVendors,
    List<IdNameEntity>? temporaryVendors,
    int? page,
  }) {
    return FilterState(
      connectorTypes: connectorTypes ?? this.connectorTypes,
      powerTypes: powerTypes ?? this.powerTypes,
      allVendors: allVendors ?? this.allVendors,
      vendors: vendors ?? this.vendors,
      temporaryVendors: temporaryVendors ?? this.temporaryVendors,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [
        connectorTypes,
        powerTypes,
        vendors,
        temporaryVendors,
        page,
        allVendors,
      ];
}
