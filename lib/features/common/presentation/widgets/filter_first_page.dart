import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/is_integrated_switch_card.dart';
import 'package:i_watt_app/features/common/presentation/blocs/filter_bloc/filter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/power_types_bloc/power_types_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/connector_types_list.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_category_title.dart';
import 'package:i_watt_app/features/common/presentation/widgets/selected_vendor_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/station_status_switches.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_switch_tile.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FilterFirstPage extends StatelessWidget {
  final ScrollController controller;

  const FilterFirstPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SelectedVendorContainer(),
          const IsIntegratedSwitchCard(),
          BlocBuilder<FilterBloc, FilterState>(
            buildWhen: (previous, current) => previous.statuses != current.statuses,
            builder: (ctx, state) {
              final filterKeys = state.statuses;
              return StationStatusSwitches(
                defaultSelectedStatuses: filterKeys,
                onChanged: (List<String> value) {
                  context.read<FilterBloc>().add(SelectStatusesEvent(statuses: value));
                },
              );
            },
          ),
          BlocBuilder<FilterBloc, FilterState>(
            buildWhen: (previous, current) => previous.connectorTypes != current.connectorTypes,
            builder: (ctx, state) {
              final connectorTypes = state.connectorTypes;
              return ConnectorTypesList(
                defaultSelectedTypes: connectorTypes,
                onChanged: (List<int> value) {
                  context.read<FilterBloc>().add(SelectConnectorTypeEvent(connectorTypes: value));
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 6),
            child: FilterCategoryTitle(title: LocaleKeys.power.tr()),
          ),
          BlocBuilder<PowerTypesBloc, PowerTypesState>(
            builder: (ctx, state) {
              return BlocBuilder<FilterBloc, FilterState>(
                buildWhen: (previous, current) => previous.powerTypes != current.powerTypes,
                builder: (context, filterState) {
                  final powerTypes = filterState.powerTypes;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      state.powerTypes.length,
                      (index) {
                        final power = state.powerTypes[index];
                        return WSwitchTile(
                          hasDivider: index != state.powerTypes.length - 1,
                          title: '${power.maxElectricPower} ${LocaleKeys.kW.tr()}',
                          includeIcon: false,
                          isSelectedDefault: powerTypes.contains(power.maxElectricPower),
                          onSwitch: (val) {
                            context.read<FilterBloc>().add(
                                  SelectPowerTypeEvent(
                                    powerType: power.maxElectricPower,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
