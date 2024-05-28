import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/pages/my_cars.dart';
import 'package:i_watt_app/features/profile/presentation/pages/saved_locations.dart';
import 'package:i_watt_app/features/profile/presentation/pages/settings_page.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/action_row_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/balance_message.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/help_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/notification_count_badge.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/user_data_container.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/white_wrapper_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AuthedUserProfileBody extends StatefulWidget {
  final ScrollController controller;
  const AuthedUserProfileBody({super.key, required this.controller});

  @override
  State<AuthedUserProfileBody> createState() => _AuthedUserProfileBodyState();
}

class _AuthedUserProfileBodyState extends State<AuthedUserProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const UserDataContainer(),
          BalanceMessage(message: '-48 000 UZS'),
          const SizedBox(height: 16),
          WhiteWrapperContainer(
            child: Column(
              children: [
                IconTextButton(
                  title: LocaleKeys.my_cards.tr(),
                  icon: AppIcons.cardBlue,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  onTap: () {},
                ),
                Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.you_saved.tr(),
                  icon: AppIcons.savings,
                  onTap: () {},
                ),
                Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.notifications.tr(),
                  icon: AppIcons.notificationsBlue,
                  actions: [
                    BlocBuilder<NotificationBloc, NotificationState>(
                      buildWhen: (o, n) => o.unReadNotificationsCount != n.unReadNotificationsCount,
                      builder: (ctx, state) {
                        final count = state.unReadNotificationsCount;
                        if (count > 0) {
                          return NotificationCountBadge(
                            count: count,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                  onTap: () {},
                ),
                Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.saved_stations.tr(),
                  icon: AppIcons.savedOutlined,
                  onTap: () => Navigator.of(context, rootNavigator: true).push(
                    MaterialWithModalsPageRoute(
                      builder: (ctx) => const SavedLocations(),
                    ),
                  ),
                ),
                Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.my_cars.tr(),
                  icon: AppIcons.carBlue,
                  onTap: () => Navigator.of(context, rootNavigator: true).push(
                    MaterialWithModalsPageRoute(
                      builder: (ctx) => const MyCarsPage(),
                    ),
                  ),
                ),
                Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.settings.tr(),
                  icon: AppIcons.settings,
                  onTap: () => Navigator.of(context, rootNavigator: true).push(
                    MaterialWithModalsPageRoute(
                      builder: (ctx) => const SettingsPage(),
                    ),
                  ),
                ),
                Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.my_stations.tr(),
                  onTap: () {},
                  icon: AppIcons.myStations,
                ),
                Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.usage_instructions.tr(),
                  onTap: () {},
                  icon: AppIcons.doc,
                ),
                Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.help.tr(),
                  icon: AppIcons.help,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      builder: (ctx) => const HelpSheet(),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.about_us.tr(),
                  icon: AppIcons.aboutUs,
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  actions: [
                    Text(
                      MyFunctions.getCurrentVersionSync(),
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.taxBreak,
                        fontSize: 12,
                      ),
                    ),
                  ],
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
