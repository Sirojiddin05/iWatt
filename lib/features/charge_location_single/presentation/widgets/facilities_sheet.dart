import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/charge_location_single_bloc/charge_location_single_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/facility_card_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FacilitiesSheet extends StatelessWidget {
  final VoidCallback onClose;

  const FacilitiesSheet({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChargeLocationSingleBloc, ChargeLocationSingleState>(
      builder: (context, state) {
        final facilities = state.location.facilities;
        return Container(
          margin: EdgeInsets.only(top: MediaQueryData.fromView(View.of(context)).padding.top),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: context.theme.scaffoldBackgroundColor,
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(17, 16, 0, 14),
                      child: Text(
                        LocaleKeys.facilities.tr(),
                        style: context.textTheme.headlineLarge?.copyWith(fontSize: 17),
                      ),
                    ),
                  ),
                  WCustomTappableButton(
                    rippleColor: Colors.white.withAlpha(50),
                    onTap: onClose,
                    borderRadius: BorderRadius.zero,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 17, 7, 11),
                      child: Text(
                        LocaleKeys.close.tr(),
                        style: context.textTheme.titleLarge!.copyWith(fontSize: 17, color: context.theme.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 1, color: context.theme.dividerColor),
              Expanded(
                child: NotificationListener(
                  onNotification: (OverscrollIndicatorNotification notification) {
                    notification.disallowIndicator();
                    return false;
                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.aliceBlue),
                    itemCount: facilities.length,
                    itemBuilder: (context, index) {
                      return FacilityCardWidget(
                        icon: facilities[index].icon,
                        title: facilities[index].name,
                        facilities: facilities[index].descriptions,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
