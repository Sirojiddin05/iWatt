import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/about_us_bloc/about_us_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/action_row_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/white_wrapper_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpSheet extends StatelessWidget {
  const HelpSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SheetWrapper(
      color: context.theme.scaffoldBackgroundColor,
      child: BlocBuilder<AboutUsBloc, AboutUsState>(
        builder: (context, state) {
          if (state.getHelpStatus.isInitial) {
            context.read<AboutUsBloc>().add(GetHelpEvent());
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SheetHeaderWidget(
                title: LocaleKeys.help.tr(),
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
                    if (state.getHelpStatus.isInProgress) ...{
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: SizedBox(
                          width: double.infinity,
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      )
                    } else if (state.getHelpStatus.isSuccess) ...{
                      IconTextButton(
                        title: state.help.helpPhoneNumber,
                        icon: AppIcons.phoneSmall,
                        padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        onTap: () {
                          launchUrlString('tel:${state.help.helpPhoneNumber}', mode: LaunchMode.externalApplication);
                        },
                      ),
                      Divider(height: 1, color: context.theme.dividerColor, thickness: 1, indent: 44),
                      IconTextButton(
                        title: state.help.helpEmail,
                        icon: AppIcons.mail,
                        padding: const EdgeInsets.all(12),
                        onTap: () {
                          launchUrlString(
                            "mailto:${state.help.helpEmail}",
                            mode: LaunchMode.externalApplication,
                          );
                        },
                      ),
                      Divider(height: 1, color: context.theme.dividerColor, thickness: 1, indent: 44),
                      IconTextButton(
                          title: state.help.helpTelegramLink,
                          icon: AppIcons.telegram,
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                          padding: const EdgeInsets.all(12),
                          onTap: () {
                            launchUrlString(state.help.helpTelegramLink, mode: LaunchMode.externalApplication);
                          }),
                    } else if (state.getHelpStatus.isFailure) ...{
                      const ErrorStateTextWidget()
                    }
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
