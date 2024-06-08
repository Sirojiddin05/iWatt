// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:i_watt_app/core/config/app_images.dart';
// import 'package:i_watt_app/core/util/my_functions.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/payment_bottom_sheet.dart';
// import 'package:i_watt_app/generated/locale_keys.g.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
//
// class BalanceInfoItem extends StatelessWidget {
//   final EdgeInsets margin;
//   const BalanceInfoItem({
//     super.key,
//     this.isMain = true,
//     this.margin = const EdgeInsets.fromLTRB(16, 25, 16, 16),
//   });
//
//   final bool isMain;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(
//       builder: (context, state) {
//         return WScaleAnimation(
//           scaleValue: isMain ? 0.95 : 1,
//           onTap: () async {
//             if (isMain) {
//               await showCupertinoModalBottomSheet(
//                 context: context,
//                 useRootNavigator: true,
//                 builder: (BuildContext context) {
//                   return const TopUpBottomSheet();
//                 },
//               );
//             }
//           },
//           child: Stack(
//             children: [
//               Container(
//                 margin: margin,
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: mainButtonColor.withOpacity(0.2)),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     gradient: LinearGradient(
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                       colors: [mainButtonColor, mainButtonColor.withOpacity(0.4)],
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 11.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               LocaleKeys.your_balance.tr(),
//                               style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12, color: shadowGreen),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               "${MyFunctions.formatDoubleNumber(state.userEntity.amount.toString())} UZS",
//                               style: Theme.of(context).textTheme.displayMedium!.copyWith(color: white),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 18,
//                 bottom: 16,
//                 child: Image.asset(
//                   AppImages.balance,
//                   width: 138,
//                   height: 83,
//                   fit: BoxFit.scaleDown,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
