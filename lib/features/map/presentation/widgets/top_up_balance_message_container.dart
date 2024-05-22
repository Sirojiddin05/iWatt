import 'package:flutter/material.dart';

class TopUpBalanceMessage extends StatelessWidget {
  const TopUpBalanceMessage({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Implement this widget
    return const SizedBox.shrink();
    // return BlocSelector<LoginBloc, LoginState, String>(
    //   selector: (state) => state.userEntity.balanceMessage ?? '',
    //   builder: (context, message) {
    //     return AnimatedScaleSizeWidget(
    //       buttonText: LocaleKeys.pay.tr(),
    //       onButtonTap: () {},
    //       iconPath: AppImages.balanceMessage,
    //       body: RichText(
    //         text: TextSpan(
    //           text: LocaleKeys.you_owe.tr(),
    //           style: context.textTheme.titleSmall!.copyWith(color: cyprus, fontSize: 13),
    //           children: [
    //             TextSpan(
    //               text: ' -48 000 UZS',
    //               style: context.textTheme.displaySmall!.copyWith(color: amaranth, fontSize: 13),
    //             ),
    //             if (context.locale.languageCode == 'uz') ...{
    //               TextSpan(
    //                 text: 'miqdorda qarzdorlik mavjud',
    //                 style: context.textTheme.headlineSmall!.copyWith(color: cyprus, fontSize: 12),
    //               ),
    //             }
    //           ],
    //         ),
    //         maxLines: 2,
    //       ),
    //       isVisible: message.isEmpty,
    //       width: context.sizeOf.width - 32,
    //     );
    //   },
    // );
  }
}
