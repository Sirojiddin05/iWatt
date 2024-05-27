import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/presentation/pages/sign_in.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/white_wrapper_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LoginToSystemContainer extends StatelessWidget {
  const LoginToSystemContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return WhiteWrapperContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AppIcons.loginToSystem),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.login_to_system.tr(),
                    style: context.theme.textTheme.headlineLarge?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    LocaleKeys.you_are_not_authorized.tr(),
                    style: context.theme.textTheme.titleMedium?.copyWith(color: AppColors.amaranth),
                  ),
                ],
              )
            ],
          ),
          WButton(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialWithModalsPageRoute(builder: (ctx) {
                return const SignInPage();
              }));
            },
            height: 40,
            margin: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.login.tr(),
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 4),
                SvgPicture.asset(AppIcons.loginIcon)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
