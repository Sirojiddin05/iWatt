import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/about_us_bloc/about_us_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/phone_number_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class BlockedSheet extends StatelessWidget {
  const BlockedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SheetWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetHeaderWidget(
            title: LocaleKeys.error.tr(),
            onClose: () => Navigator.of(context)
              ..pop()
              ..pop(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 32, 8),
            child: Text(
              LocaleKeys.too_many_attempts.tr(),
              style: context.textTheme.headlineLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              LocaleKeys.you_entered_wrong_code_three_times.tr(),
              style: context.textTheme.labelMedium?.copyWith(color: AppColors.taxBreak),
            ),
          ),
          BlocBuilder<AboutUsBloc, AboutUsState>(
            builder: (context, state) {
              return PhoneNumberContainer(phoneNumber: state.aboutUs.phone);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              LocaleKeys.support_service_number.tr(),
              style: context.textTheme.labelMedium?.copyWith(color: AppColors.taxBreak),
            ),
          ),
          SizedBox(height: context.padding.bottom + 16),
        ],
      ),
    );
  }
}
