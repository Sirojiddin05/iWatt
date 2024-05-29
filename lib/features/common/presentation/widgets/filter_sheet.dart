import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/power_types_bloc/power_types_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/aplly_filter_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/connector_types_list.dart';
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
                  ConnectorTypesList(
                    defaultSelectedTypes: connectorTypes.value,
                    onChanged: (List<int> value) {
                      connectorTypes.value = [...value];
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 0, 6),
                    child: FilterCategoryTitle(title: LocaleKeys.power.tr()),
                  ),
                  BlocBuilder<PowerTypesBloc, PowerTypesState>(builder: (ctx, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        state.powerTypes.length,
                        (index) {
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
                                },
                              );
                            },
                          );
                        },
                      ),
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
