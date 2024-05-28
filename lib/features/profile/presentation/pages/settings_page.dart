import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/car_on_map_bloc/car_on_map_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_cupertino_switch.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/action_row_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_on_map_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/lang_bottomsheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/theme_swither_widget.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/white_wrapper_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWrapper(
        title: LocaleKeys.settings.tr(),
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WhiteWrapperContainer(
              child: Column(
                children: [
                  IconTextButton(
                    title: LocaleKeys.interface_language.tr(),
                    icon: AppIcons.language,
                    rippleColor: context.theme.splashColor,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    actions: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppConstants.languageList.firstWhere((element) => element.locale.languageCode == context.locale.languageCode).icon,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppConstants.languageList.firstWhere((element) => element.locale.languageCode == context.locale.languageCode).title,
                            style: context.theme.textTheme.titleMedium?.copyWith(color: AppColors.taxBreak, fontSize: 12),
                          ),
                        ],
                      )
                    ],
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const LanguageBottomSheet();
                        },
                      );
                    },
                  ),
                  Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                  IconTextButton(
                    title: LocaleKeys.currency.tr(),
                    icon: AppIcons.currency,
                    rippleColor: context.theme.splashColor,
                    actions: [
                      Text(
                        'UZS',
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.taxBreak,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    onTap: () {},
                  ),
                  Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                  IconTextButton(
                    title: LocaleKeys.unit.tr(),
                    icon: AppIcons.unit,
                    rippleColor: context.theme.splashColor,
                    actions: [
                      Text(
                        LocaleKeys.meter.tr(),
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.taxBreak,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    onTap: () {},
                  ),
                  Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (ctx, state) {
                      final isAuthenticated = state.authenticationStatus.isAuthenticated;
                      return Column(
                        children: [
                          IconTextButton(
                            title: LocaleKeys.car_on_map.tr(),
                            icon: AppIcons.carOnMap,
                            rippleColor: context.theme.splashColor,
                            padding:
                                !isAuthenticated ? const EdgeInsets.fromLTRB(12, 8, 12, 12) : const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            borderRadius: !isAuthenticated
                                ? const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
                                : BorderRadius.zero,
                            actions: [
                              BlocBuilder<CarOnMapBloc, CarOnMapState>(
                                buildWhen: (o, n) => o.carOnMap != n.carOnMap,
                                builder: (context, state) {
                                  return Text(
                                    state.carOnMap.title.tr(),
                                    style: context.theme.textTheme.titleMedium?.copyWith(
                                      color: AppColors.taxBreak,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                            ],
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (ctx) {
                                    return const CarOnMapSheet();
                                  });
                            },
                          ),
                          if (isAuthenticated) ...{
                            Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                            IconTextButton(
                              title: LocaleKeys.notifications.tr(),
                              icon: AppIcons.notificationsGrey,
                              rippleColor: context.theme.splashColor,
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                              actions: [
                                BlocBuilder<ProfileBloc, ProfileState>(
                                  builder: (context, state) {
                                    final areNotificationsOn = state.user.areNotificationsOn;
                                    return WCupertinoSwitch(
                                      isSwitched: areNotificationsOn,
                                      onChange: (v) {
                                        context.read<NotificationBloc>().add(NotificationOnOff(enabled: !areNotificationsOn));
                                      },
                                    );
                                  },
                                )
                              ],
                              onTap: () {},
                            ),
                          }
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            const ThemeSwitcherWidget(),
          ],
        ),
      ),
      bottomNavigationBar: WButton(
        onTap: () {},
        margin: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          context.padding.bottom + 16,
        ),
        color: AppColors.amaranth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.log_out.tr(),
              style: context.textTheme.bodySmall?.copyWith(color: AppColors.white),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(AppIcons.logOutIcon)
          ],
        ),
      ),
    );
  }
}
