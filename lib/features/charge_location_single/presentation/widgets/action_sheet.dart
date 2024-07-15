import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/authorization/presentation/pages/sign_in.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/charge_location_single_entity.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/appeals_list.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_close_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
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
        color: context.colorScheme.primaryContainer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SheetHeadContainer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: Text(
                      '${location.vendor.name} "${location.name}"',
                      style: context.textTheme.displayMedium,
                    ),
                  ),
                ),
                SheetCloseButton(
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // IconTextButton(
                //   title: LocaleKeys.share.tr(),
                //   icon: AppIcons.share,
                //   rippleColor: AppColors.brightSun.withAlpha(30),
                //   padding: const EdgeInsets.fromLTRB(12, 14, 12, 8),
                //   borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                //   onTap: () async {
                //     Navigator.pop(context);
                //     await Share.share('${location.vendor.name} "${location.name}"\napp.i-watt.uz/location/${location.id}');
                //   },
                // ),
                // Divider(color: context.theme.dividerColor, height: 1, indent: 44),
                // IconTextButton(
                //   title: LocaleKeys.to_complain.tr(),
                //   icon: AppIcons.alert,
                //   rippleColor: AppColors.amaranth.withAlpha(30),
                //   padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                //   borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                //   onTap: () {
                //     Navigator.pop(context);
                //     showModalBottomSheet(
                //       context: context,
                //       isScrollControlled: true,
                //       enableDrag: true,
                //       backgroundColor: Colors.transparent,
                //       builder: (context) => AppealsList(
                //         location: location.id,
                //       ),
                //     );
                //   },
                // ),
                const SizedBox(width: 16),
                WButton(
                  onTap: () async {
                    Navigator.pop(context);
                    await Share.share('${location.vendor.name} "${location.name}"\napp.i-watt.uz/location/${location.id}');
                  },
                  color: AppColors.sun.withOpacity(0.18),
                  rippleColor: AppColors.sun.withAlpha(30),
                  padding: const EdgeInsets.all(7),
                  child: SvgPicture.asset(AppIcons.shareBig),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: WButton(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.route),
                        const SizedBox(width: 12),
                        Text(
                          LocaleKeys.route.tr(),
                          style: context.textTheme.bodySmall?.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                WButton(
                  onTap: () {
                    if (context.read<AuthenticationBloc>().state.authenticationStatus.isAuthenticated) {
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
                    } else {
                      showLoginDialog(context, onConfirm: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignInPage()));
                      });
                    }
                  },
                  padding: const EdgeInsets.all(7),
                  rippleColor: AppColors.amaranth.withAlpha(30),
                  color: AppColors.amaranth.withOpacity(0.18),
                  child: SvgPicture.asset(AppIcons.compliance),
                ),
                const SizedBox(width: 16),
              ],
            ),
            SizedBox(
              height: context.padding.bottom + 12,
            )
          ],
        ),
      ),
    );
  }
}
