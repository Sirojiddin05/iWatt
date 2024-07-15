import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc({
    required List<int> defaultSelectedConnectorTypes,
    required List<int> defaultSelectedPowerTypes,
    required List<IdNameEntity> defaultSelectedVendors,
    required List<String> defaultSelectedStatuses,
    required bool integrated,
  }) : super(FilterState(
          integrated: integrated,
          statuses: defaultSelectedStatuses,
          connectorTypes: defaultSelectedConnectorTypes,
          powerTypes: defaultSelectedPowerTypes,
          vendors: defaultSelectedVendors,
          temporaryVendors: defaultSelectedVendors,
        )) {
    on<SelectConnectorTypeEvent>(_selectConnectorType);
    on<SelectStatusesEvent>(_selectStatuses);
    on<SelectPowerTypeEvent>(_selectPowerType);
    on<SelectAllVendorsEvent>(_selectAllVendors);
    on<UnSelectAllVendorsEvent>(_unSelectAllVendors);
    on<SelectVendorEvent>(_selectVendor);
    on<UnSelectVendorEvent>(_unSelectVendor);
    on<SetVendorsEvent>(_setVendors);
    on<SetTemporaryVendors>(_setTemporaryVendors);
    on<SetPageEvent>(_setPage);
    on<ClearFilterEvent>(_clearFilter);
    on<ChangeVendorsList>(_changeVendorsList);
    on<SwitchIntegratedEvent>(_switchIntegrated);
  }

  void _selectStatuses(SelectStatusesEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(statuses: event.statuses));
  }

  void _selectConnectorType(SelectConnectorTypeEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(connectorTypes: event.connectorTypes));
  }

  void _switchIntegrated(SwitchIntegratedEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(integrated: !state.integrated));
  }

  void _selectPowerType(SelectPowerTypeEvent event, Emitter<FilterState> emit) {
    final powerTypes = List<int>.from(state.powerTypes);
    if (powerTypes.contains(event.powerType)) {
      powerTypes.remove(event.powerType);
    } else {
      powerTypes.add(event.powerType);
    }
    emit(state.copyWith(powerTypes: powerTypes));
  }

  void _selectAllVendors(SelectAllVendorsEvent event, Emitter<FilterState> emit) {
    final vendors = List<IdNameEntity>.from(state.temporaryVendors);
    final vendorIds = List<int>.generate(vendors.length, (index) => vendors[index].id);
    for (var e in event.vendors) {
      if (!vendorIds.contains(e.id)) {
        vendors.add(e);
      }
    }
    emit(state.copyWith(temporaryVendors: vendors));
  }

  void _unSelectAllVendors(UnSelectAllVendorsEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(temporaryVendors: []));
  }

  void _selectVendor(SelectVendorEvent event, Emitter<FilterState> emit) {
    final selectedVendors = List<IdNameEntity>.from(state.temporaryVendors);
    selectedVendors.add(event.vendor);
    final allVendors = state.allVendors;
    final List<int> allVendorsIds = List<int>.generate(allVendors.length, (index) => allVendors[index].id);
    if ((selectedVendors.length == allVendors.length - 1) && allVendorsIds.contains(0)) {
      selectedVendors.add(
        IdNameEntity(
          id: 0,
          name: LocaleKeys.select_all.tr(),
          logo: AppIcons.selectAll,
        ),
      );
    }
    emit(state.copyWith(temporaryVendors: selectedVendors));
  }

  void _unSelectVendor(UnSelectVendorEvent event, Emitter<FilterState> emit) {
    final vendors = List<IdNameEntity>.from(state.temporaryVendors);
    vendors.removeWhere((e) => e.id == event.vendor.id);
    vendors.removeWhere((e) => e.id == 0);
    emit(state.copyWith(temporaryVendors: vendors));
  }

  void _setPage(SetPageEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _clearFilter(ClearFilterEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(
      temporaryVendors: [],
      powerTypes: [],
      connectorTypes: [],
      vendors: [],
      statuses: [],
      integrated: false,
    ));
  }

  void _setVendors(SetVendorsEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(vendors: state.temporaryVendors));
    add(const SetPageEvent(page: 0));
  }

  void _setTemporaryVendors(SetTemporaryVendors event, Emitter<FilterState> emit) {
    emit(state.copyWith(temporaryVendors: state.vendors));
  }

  void _changeVendorsList(ChangeVendorsList event, Emitter<FilterState> emit) {
    final vendors = List<IdNameEntity>.from(state.allVendors);
    final vendorIds = List<int>.generate(vendors.length, (index) => vendors[index].id);
    for (var e in event.vendors) {
      if (!vendorIds.contains(e.id)) {
        vendors.add(e);
      }
    }
    emit(state.copyWith(allVendors: vendors));
    final customVendor = state.temporaryVendors.firstWhere(
      (e) => e.id == 0,
      orElse: () => const IdNameEntity(),
    );
    if (customVendor.id == 0) {
      add(SelectAllVendorsEvent(event.vendors));
    }
  }
}
