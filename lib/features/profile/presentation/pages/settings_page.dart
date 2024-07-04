import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/authentication_status.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/car_on_map_bloc/car_on_map_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_cupertino_switch.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/action_row_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_on_map_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/lang_bottomsheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/white_wrapper_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: context.theme.scaffoldBackgroundColor,
      ),
      child: Scaffold(
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
                          builder: (ctx) {
                            return BlocProvider.value(
                              value: context.read<ProfileBloc>(),
                              child: const LanguageBottomSheet(),
                            );
                          },
                        );
                      },
                    ),
                    Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                    //TODO next version
                    // IconTextButton(
                    //   title: LocaleKeys.currency.tr(),
                    //   icon: AppIcons.currency,
                    //   rippleColor: context.theme.splashColor,
                    //   actions: [
                    //     Text(
                    //       'UZS',
                    //       style: context.theme.textTheme.titleMedium?.copyWith(
                    //         color: AppColors.taxBreak,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //   ],
                    //   onTap: () {},
                    // ),
                    // Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                    // IconTextButton(
                    //   title: LocaleKeys.unit.tr(),
                    //   icon: AppIcons.unit,
                    //   rippleColor: context.theme.splashColor,
                    //   actions: [
                    //     Text(
                    //       LocaleKeys.meter.tr(),
                    //       style: context.theme.textTheme.titleMedium?.copyWith(
                    //         color: AppColors.taxBreak,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //   ],
                    //   onTap: () {},
                    // ),
                    // Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (ctx, state) {
                        final isAuthenticated = state.authenticationStatus.isAuthenticated;
                        return Column(
                          children: [
                            IconTextButton(
                              title: LocaleKeys.car_on_map.tr(),
                              icon: AppIcons.carOnMap,
                              rippleColor: context.theme.splashColor,
                              padding: !isAuthenticated
                                  ? const EdgeInsets.fromLTRB(12, 8, 12, 12)
                                  : const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                                showCarOnMapSheet(context);
                              },
                            ),
                            if (isAuthenticated) ...{
                              Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                              BlocConsumer<ProfileBloc, ProfileState>(
                                listenWhen: (o, n) {
                                  final notificationsChanged = o.user.isNotificationEnabled != n.user.isNotificationEnabled;
                                  final updateStatusChanged = o.updateProfileStatus != n.updateProfileStatus;
                                  return notificationsChanged && updateStatusChanged;
                                },
                                listener: (context, state) {
                                  if (state.updateProfileStatus.isFailure) {
                                    context.showPopUp(
                                      context,
                                      PopUpStatus.failure,
                                      message: state.updateErrorMessage,
                                    );
                                  }
                                },
                                buildWhen: (o, n) => o.user.isNotificationEnabled != n.user.isNotificationEnabled,
                                builder: (context, state) {
                                  final areNotificationsOn = state.user.isNotificationEnabled;
                                  return IconTextButton(
                                    title: LocaleKeys.notifications.tr(),
                                    icon: AppIcons.notificationsGrey,
                                    rippleColor: context.theme.splashColor,
                                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                                    actions: [
                                      WCupertinoSwitch(
                                        isSwitched: areNotificationsOn,
                                        onChange: (v) async {
                                          if (areNotificationsOn) {
                                            context.read<ProfileBloc>().add(UpdateProfile(isNotificationEnabled: !areNotificationsOn));
                                          } else {
                                            final permissionIsGranted = await Permission.notification.isGranted;
                                            if (permissionIsGranted) {
                                              final requested = await Permission.notification.request();
                                              if (requested.isGranted) {
                                                context.read<ProfileBloc>().add(UpdateProfile(isNotificationEnabled: true));
                                              } else {
                                                context.showPopUp(
                                                  context,
                                                  PopUpStatus.failure,
                                                  message: LocaleKeys.notification_permission_denied.tr(),
                                                );
                                              }
                                            }
                                          }
                                        },
                                      )
                                    ],
                                    onTap: () {
                                      context.read<ProfileBloc>().add(UpdateProfile(isNotificationEnabled: !areNotificationsOn));
                                    },
                                  );
                                },
                              ),
                            }
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              //TODO next version
              // const ThemeSwitcherWidget(),
            ],
          ),
        ),
        bottomNavigationBar: WButton(
          onTap: () {
            showCustomAdaptiveDialog(
              context,
              title: LocaleKeys.log_out_from_account.tr(),
              description: LocaleKeys.are_you_sure_you_want_to_log_out.tr(),
              confirmText: LocaleKeys.log_out.tr(),
              confirmStyle: context.textTheme.titleLarge?.copyWith(color: AppColors.redOrange, fontSize: 17),
              onConfirm: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationStatusChanged(authenticationStatus: AuthenticationStatus.unauthenticated, isRebuild: true));
              },
            );
          },
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
      ),
    );
  }
}
