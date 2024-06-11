import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/charge_location_single_bloc/charge_location_single_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_actions_wrapper.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/select_station_sheet.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ChargingStationsBottomWidget extends StatelessWidget {
  const ChargingStationsBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        context.padding.bottom + 16,
      ),
      child: BlocBuilder<ChargeLocationSingleBloc, ChargeLocationSingleState>(
        // buildWhen: (o, n) => o.selectedStationIndex != n.selectedStationIndex,
        builder: (context, state) {
          return Row(
            children: [
              if (state.location.chargers.length > 1) ...{
                IgnorePointer(
                  ignoring: state.selectedStationIndex == 0,
                  child: LocationSingleActionsWrapper(
                    onTap: () {
                      if (state.selectedStationIndex != 0) {
                        context.read<ChargeLocationSingleBloc>().add(ChangeSelectedStationIndex(state.selectedStationIndex - 1));
                      }
                    },
                    child: SvgPicture.asset(
                      AppIcons.chevronLeftBlack,
                      color: state.selectedStationIndex == 0 ? context.theme.dividerColor : null,
                    ),
                  ),
                ),
              },
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: LocationSingleActionsWrapper(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (ctx) {
                          return BlocProvider.value(
                            value: BlocProvider.of<ChargeLocationSingleBloc>(context),
                            child: const SelectStationSheet(),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcons.stationWhite, color: AppColors.limeGreen),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            getStationTitle(state),
                            style: context.textTheme.headlineLarge,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(AppIcons.list),
                      ],
                    ),
                  ),
                ),
              ),
              if (state.location.chargers.length > 1) ...{
                IgnorePointer(
                  ignoring: state.selectedStationIndex == (state.location.chargers.length - 1),
                  child: LocationSingleActionsWrapper(
                    onTap: () {
                      if (state.selectedStationIndex != (state.location.chargers.length - 1)) {
                        context.read<ChargeLocationSingleBloc>().add(ChangeSelectedStationIndex(state.selectedStationIndex + 1));
                      }
                    },
                    child: SvgPicture.asset(
                      AppIcons.chevronRightGrey,
                      height: 24,
                      width: 24,
                      color: state.selectedStationIndex == (state.location.chargers.length - 1) ? context.theme.dividerColor : AppColors.cyprus,
                    ),
                  ),
                ),
              }
            ],
          );
        },
      ),
    );
  }

  String getStationTitle(ChargeLocationSingleState state) {
    final station = state.location.chargers[state.selectedStationIndex];
    final maxPower = state.location.chargers[state.selectedStationIndex].maxElectricPower;
    if (maxPower > 0) {
      return '${station.name}($maxPower ${LocaleKeys.kW.tr()})';
    }
    return station.name;
  }
}
