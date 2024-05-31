import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/map/presentation/widgets/animated_size_scale_map_widget.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class TopUpBalanceMessage extends StatelessWidget {
  const TopUpBalanceMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileBloc, ProfileState, String>(
      selector: (state) => state.user.balance,
      builder: (context, message) {
        return AnimatedScaleSizeWidget(
          buttonText: LocaleKeys.pay.tr(),
          onButtonTap: () {},
          iconPath: AppImages.balanceMessage,
          body: RichText(
            text: TextSpan(
              text: LocaleKeys.you_owe.tr(),
              style: context.textTheme.titleLarge!.copyWith(color: AppColors.cyprus),
              children: [
                TextSpan(
                  text: '\n${MyFunctions.getBalanceMessage(message)} UZS',
                  style: context.textTheme.displaySmall!.copyWith(color: AppColors.amaranth, fontSize: 13),
                ),
                // if (context.locale.languageCode == 'uz') ...{
                //   //TODO
                //   TextSpan(
                //     text: 'miqdorda qarzdorlik mavjud',
                //     style: context.textTheme.headlineSmall!.copyWith(color: cyprus, fontSize: 12),
                //   ),
                // }
              ],
            ),
            maxLines: 2,
          ),
          isVisible: message.contains('-'),
          width: context.sizeOf.width - 32,
        );
      },
    );
  }
}
