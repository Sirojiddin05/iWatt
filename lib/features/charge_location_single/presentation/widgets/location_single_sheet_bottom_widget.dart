import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/charge_location_single_bloc/charge_location_single_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/action_sheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/saved_icon_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class LocationSingleSheetBottomWidget extends StatelessWidget {
  final VoidCallback onChargeTap;
  const LocationSingleSheetBottomWidget({super.key, required this.onChargeTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: BlocBuilder<ChargeLocationSingleBloc, ChargeLocationSingleState>(
        // buildWhen: (o, n) => o.location != n.location,
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(bottom: context.padding.bottom),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  ...(List.generate(10, (index) => context.colorScheme.background)),
                  context.colorScheme.background.withOpacity(.9),
                  context.colorScheme.background.withOpacity(.7),
                  context.colorScheme.background.withOpacity(.5),
                  context.colorScheme.background.withOpacity(.3),
                  context.colorScheme.background.withOpacity(.1),
                  context.colorScheme.background.withOpacity(0),
                ],
              ),
            ),
            child: Row(
              children: [
                SavedUnSaveButton(
                  size: 24,
                  location: ChargeLocationEntity(
                    id: state.location.id,
                    address: state.location.address,
                    distance: state.location.distance,
                    isFavorite: state.location.isFavorite,
                    logo: state.location.vendor.logo,
                    locationName: state.location.name,
                  ),
                ),
                Expanded(
                  child: WButton(
                    height: 40,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    borderRadius: 20,
                    color: AppColors.limeGreen,
                    rippleColor: AppColors.white.withAlpha(30),
                    onTap: () {
                      if (state.location.chargers.isNotEmpty) {
                        print('state.location.chargers.isNotEmpty');
                        context
                            .read<ChargeLocationSingleBloc>()
                            .add(ChangeSelectedStationIndexByConnectorId(state.location.chargers.first.connectors.first.id));
                      }
                      onChargeTap();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppIcons.stationWhite),
                        const SizedBox(width: 6),
                        Text(
                          LocaleKeys.charge.tr(),
                          style: context.textTheme.bodySmall!.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                WScaleAnimation(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black.withOpacity(.52),
                      builder: (context) {
                        return ActionSheet(
                          location: state.location,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 16, 20),
                    child: SvgPicture.asset(
                      AppIcons.dotsHorizontal,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
