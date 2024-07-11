import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/location_filter_key_bloc/location_filter_key_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_category_title.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_switch_tile.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class StationStatusSwitches extends StatefulWidget {
  final List<String> defaultSelectedStatuses;
  final ValueChanged<List<String>> onChanged;

  const StationStatusSwitches({super.key, required this.defaultSelectedStatuses, required this.onChanged});

  @override
  State<StationStatusSwitches> createState() => _StationStatusSwitchesState();
}

class _StationStatusSwitchesState extends State<StationStatusSwitches> {
  late final ValueNotifier<List<String>> filterKeys;

  @override
  void initState() {
    super.initState();
    filterKeys = ValueNotifier<List<String>>([]);
    filterKeys.value = [...widget.defaultSelectedStatuses];
  }

  @override
  void didUpdateWidget(covariant StationStatusSwitches oldWidget) {
    filterKeys.value = [...widget.defaultSelectedStatuses];
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationFilterKeyBloc, LocationFilterKeyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: FilterCategoryTitle(title: LocaleKeys.location_status.tr()),
            ),
            ...List.generate(
              state.filterKeys.length,
              (index) {
                final filterKey = state.filterKeys[index];
                return ValueListenableBuilder<List<String>>(
                  valueListenable: filterKeys,
                  builder: (context, v, child) {
                    return WSwitchTile(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      includeIcon: true,
                      icon: filterKey.icon,
                      hasDivider: index != state.filterKeys.length - 1,
                      title: filterKey.title,
                      isSelectedDefault: filterKeys.value.contains(filterKey.key),
                      onSwitch: (val) {
                        if (val) {
                          filterKeys.value = [...filterKeys.value, filterKey.key];
                        } else {
                          filterKeys.value.remove(filterKey.key);
                          filterKeys.value = [...filterKeys.value];
                        }
                        widget.onChanged(filterKeys.value);
                      },
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
