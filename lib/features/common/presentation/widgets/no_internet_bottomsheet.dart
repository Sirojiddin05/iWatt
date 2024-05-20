import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/internet_bloc/internet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class NoInternetBottomSheet extends StatelessWidget {
  const NoInternetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetBloc, InternetState>(builder: (context, state) {
      return PopScope(
        canPop: state.isConnected,
        child: Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 46),
              SvgPicture.asset(AppIcons.noInternet),
              Text(
                '🙈${LocaleKeys.no_network.tr()}',
                style: context.textTheme.displayLarge,
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  LocaleKeys.check_connection_and_update.tr(),
                  //TODO: Adapt color of text to appTheme
                  style: context.textTheme.labelMedium?.copyWith(color: AppColors.taxBreak),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              WButton(
                isLoading: state.status == FormzSubmissionStatus.inProgress,
                margin: EdgeInsets.only(bottom: context.padding.bottom),
                onTap: () => context.read<InternetBloc>().add(CheckConnectionEvent()),
                text: LocaleKeys.refresh_the_page.tr(),
              ),
            ],
          ),
        ),
      );
    });
  }
}

void showNoInternetBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isDismissible: false,
    context: context,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) => const NoInternetBottomSheet(),
  );
}
