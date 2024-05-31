// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
// import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
// import 'package:i_watt_app/generated/locale_keys.g.dart';
// import 'package:i_watt_inapp/assets/colors/colors.dart';
// import 'package:i_watt_inapp/assets/constants/app_icons.dart';
// import 'package:i_watt_inapp/features/location_single/presentation/widgets/facility_card_widget.dart';
// import 'package:i_watt_inapp/generated/locale_keys.g.dart';
// import 'package:i_watt_inapp/utils/extensions.dart';
//
// class FacilitiesSheet extends StatelessWidget {
//   const FacilitiesSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(17, 16, 0, 14),
//                 child: Text(
//                   LocaleKeys.facilities.tr(),
//                   style: context.textTheme.headlineLarge?.copyWith(fontSize: 17),
//                 ),
//               ),
//             ),
//             TouchRipple(
//               rippleColor: white.withAlpha(50),
//               onTap: () => Navigator.pop(context),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(8, 17, 7, 11),
//                 child: Text(
//                   LocaleKeys.close.tr(),
//                   style: context.textTheme.titleLarge!.copyWith(fontSize: 17, color: mainButtonColor),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const Divider(height: 1, color: solitude),
//         Expanded(
//           child: NotificationListener(
//             onNotification: (OverscrollIndicatorNotification notification) {
//               notification.disallowIndicator();
//               return false;
//             },
//             child: ListView(
//               children: const [
//                 FacilityCardWidget(
//                   icon: AppIcons.shoppingCart,
//                   title: "Доставка",
//                   facilities: [
//                     "Удобная оплата",
//                     "Отслеживание заказа",
//                     "Гибкий график доставки",
//                     "Экологичная упаковкаЭкологичная упаковкаЭкологичная упаковка",
//                     "Гибкий график доставки",
//                     "Экологичная упаковкаЭкологичная упаковкаЭкологичная упаковка",
//                     "Гибкий график доставки",
//                     "Экологичная упаковкаЭкологичная упаковкаЭкологичная упаковка",
//                   ],
//                 ),
//                 Divider(height: 1, color: aliceBlue),
//                 FacilityCardWidget(
//                   icon: AppIcons.shoppingCart,
//                   title: "Доставка",
//                   facilities: [
//                     "Удобная оплата",
//                     "Отслеживание заказа",
//                     "Гибкий график доставки",
//                     "Экологичная упаковка",
//                   ],
//                 ),
//                 Divider(height: 1, color: aliceBlue),
//                 FacilityCardWidget(
//                   icon: AppIcons.shoppingCart,
//                   title: "Доставка",
//                   facilities: [
//                     "Удобная оплата",
//                     "Отслеживание заказа",
//                     "Гибкий график доставки",
//                     "Гибкий график доставки",
//                     "Экологичная упаковка",
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
