import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/charge_location_single_entity.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/appeals_list.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/action_row_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/white_wrapper_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:share_plus/share_plus.dart';

class ActionSheet extends StatelessWidget {
  final ChargeLocationSingleEntity location;
  const ActionSheet({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: context.theme.scaffoldBackgroundColor,
      ),
      child: SheetWrapper(
        color: context.theme.scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeaderWidget(
              title: LocaleKeys.action.tr(),
            ),
            WhiteWrapperContainer(
              margin: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                context.padding.bottom + 16,
              ),
              child: Column(
                children: [
                  IconTextButton(
                    title: LocaleKeys.share.tr(),
                    icon: AppIcons.share,
                    rippleColor: AppColors.brightSun.withAlpha(30),
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 8),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    onTap: () async {
                      Navigator.pop(context);
                      await Share.share('${location.vendor.name} "${location.name}"\napp.i-watt.uz/location/${location.id}');
                    },
                  ),
                  Divider(color: context.theme.dividerColor, height: 1, indent: 44),
                  IconTextButton(
                    title: LocaleKeys.to_complain.tr(),
                    icon: AppIcons.alert,
                    rippleColor: AppColors.amaranth.withAlpha(30),
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => AppealsList(
                          location: location.id,
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
