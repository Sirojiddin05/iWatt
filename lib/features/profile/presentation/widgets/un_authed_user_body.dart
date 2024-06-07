import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/navigation/presentation/blocs/instructions_bloc/instructions_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/version_features_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/action_row_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/help_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/login_to_system_container.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/white_wrapper_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class UnAuthedUserBody extends StatefulWidget {
  final ScrollController controller;

  const UnAuthedUserBody({super.key, required this.controller});

  @override
  State<UnAuthedUserBody> createState() => _UnAuthedUserBodyState();
}

class _UnAuthedUserBodyState extends State<UnAuthedUserBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const LoginToSystemContainer(),
          const SizedBox(height: 16),
          WhiteWrapperContainer(
            child: Column(
              children: [
                // IconTextButton(
                //   title: LocaleKeys.settings.tr(),
                //   icon: AppIcons.settings,
                //   padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                //   borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                //   onTap: () => Navigator.of(context, rootNavigator: true).push(
                //     MaterialWithModalsPageRoute(
                //       builder: (ctx) => const SettingsPage(),
                //     ),
                //   ),
                // ),
                // Divider(height: 1, thickness: 1, color: context.theme.dividerColor, indent: 48),
                IconTextButton(
                  title: LocaleKeys.usage_instructions.tr(),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      isScrollControlled: true,
                      useRootNavigator: true,
                      backgroundColor: Colors.transparent,
                      constraints: BoxConstraints(maxHeight: context.sizeOf.height * 0.75),
                      builder: (context) => BlocBuilder<InstructionsBloc, InstructionsState>(
                        builder: (context, state) {
                          return VersionFeaturesSheet(list: state.instructions);
                        },
                      ),
                    );
                  },
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
