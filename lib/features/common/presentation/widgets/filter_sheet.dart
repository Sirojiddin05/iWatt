import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/connector_types_bloc/connector_types_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/power_types_bloc/power_types_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/aplly_filter_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_category_title.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_header.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_tile.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FilterSheet extends StatefulWidget {
  final Function(List<int> powerTypes, List<int> connectorType) onChanged;
  final List<int> selectedPowerTypes;
  final List<int> selectedConnectorTypes;

  const FilterSheet({super.key, required this.onChanged, required this.selectedPowerTypes, required this.selectedConnectorTypes});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late final ValueNotifier<List<int>> connectorTypes;
  late final ValueNotifier<List<int>> powerTypes;

  @override
  void initState() {
    super.initState();
    connectorTypes = ValueNotifier<List<int>>([]);
    powerTypes = ValueNotifier<List<int>>([]);
    connectorTypes.value = [...widget.selectedConnectorTypes];
    powerTypes.value = [...widget.selectedPowerTypes];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: context.colorScheme.primaryContainer,
      ),
      margin: const EdgeInsets.only(top: kToolbarHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterHeader(
            onClearTap: () {
              connectorTypes.value = [];
              powerTypes.value = [];
            },
            connectorTypes: connectorTypes,
            powerTypes: powerTypes,
          ),
          Divider(thickness: 1, color: context.theme.dividerColor, height: 0),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
                    child: FilterCategoryTitle(title: 'AC:'),
                  ),
                  BlocBuilder<ConnectorTypesBloc, ConnectorTypesState>(builder: (ctx, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                          state.acConnectionTypes.length,
                          (index) {
                            final connector = state.acConnectionTypes[index];
                            return ValueListenableBuilder<List<int>>(
                              valueListenable: connectorTypes,
                              builder: (context, v, child) {
                                return FilterTile(
                                  includeIcon: true,
                                  hasDivider: index != state.acConnectionTypes.length - 1,
                                  title: connector.name,
                                  isSelectedDefault: connectorTypes.value.contains(connector.id),
                                  onSwitch: (val) {
                                    if (val) {
                                      connectorTypes.value = [...connectorTypes.value, connector.id];
                                    } else {
                                      connectorTypes.value.remove(connector.id);
                                      connectorTypes.value = [...connectorTypes.value];
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 12, 0, 8),
                          child: FilterCategoryTitle(title: 'DC:'),
                        ),
                        ...List.generate(state.dcConnectionTypes.length, (index) {
                          final connector = state.dcConnectionTypes[index];
                          return ValueListenableBuilder<List<int>>(
                              valueListenable: connectorTypes,
                              builder: (context, v, child) {
                                return FilterTile(
                                    hasDivider: index != state.dcConnectionTypes.length - 1,
                                    includeIcon: true,
                                    title: connector.name,
                                    isSelectedDefault: connectorTypes.value.contains(connector.id),
                                    onSwitch: (val) {
                                      if (val) {
                                        connectorTypes.value = [...connectorTypes.value, connector.id];
                                      } else {
                                        connectorTypes.value.remove(connector.id);
                                        connectorTypes.value = [...connectorTypes.value];
                                      }
                                    });
                              });
                        })
                      ],
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 0, 6),
                    child: FilterCategoryTitle(title: LocaleKeys.power.tr()),
                  ),
                  BlocBuilder<PowerTypesBloc, PowerTypesState>(builder: (ctx, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(state.powerTypes.length, (index) {
                        final power = state.powerTypes[index];
                        return ValueListenableBuilder<List<int>>(
                            valueListenable: powerTypes,
                            builder: (context, v, child) {
                              return FilterTile(
                                  hasDivider: index != state.powerTypes.length - 1,
                                  title: power.name,
                                  includeIcon: false,
                                  isSelectedDefault: powerTypes.value.contains(power.id),
                                  onSwitch: (val) {
                                    if (val) {
                                      powerTypes.value = [...powerTypes.value, power.id];
                                    } else {
                                      powerTypes.value.remove(power.id);
                                      powerTypes.value = [...powerTypes.value];
                                    }
                                  });
                            });
                      }),
                    );
                  })
                ],
              ),
            ),
          ),
          ApplyFilterButton(
            onTap: () => widget.onChanged(powerTypes.value, connectorTypes.value),
          ),
        ],
      ),
    );
  }
}
