import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/charge_location_single_bloc/charge_location_single_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/selectable_station_item.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class SelectStationSheet extends StatefulWidget {
  const SelectStationSheet({super.key});

  @override
  State<SelectStationSheet> createState() => _SelectStationSheetState();
}

class _SelectStationSheetState extends State<SelectStationSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHeadContainer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  LocaleKeys.select_station.tr(),
                  style: context.textTheme.displayMedium,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: SvgPicture.asset(AppIcons.close, color: AppColors.blueBayoux),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 1, color: context.theme.dividerColor, thickness: 1),
          BlocBuilder<ChargeLocationSingleBloc, ChargeLocationSingleState>(
            builder: (context, state) {
              return Column(
                children: List.generate(
                  state.location.chargers.length,
                  (index) => SelectableStationItem(
                    value: index,
                    groupValue: state.selectedStationIndex,
                    connectors: state.location.chargers[index].connectors,
                    title: state.location.chargers[index].name,
                    onTap: () {
                      context.read<ChargeLocationSingleBloc>().add(ChangeSelectedStationIndex(index));
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(height: context.padding.bottom + 16),
        ],
      ),
    );
  }
}
