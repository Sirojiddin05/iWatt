// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:i_watt_app/core/config/app_icons.dart';
// import 'package:i_watt_app/features/charge_location_single/presentation/widgets/contacts_card_row.dart';
// import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_card_wrapper.dart';
// import 'package:i_watt_app/generated/locale_keys.g.dart';
//
// class ContactsCard extends StatelessWidget {
//   final String email;
//   final String phone;
//   final String website;
//   const ContactsCard({
//     super.key,
//     required this.email,
//     required this.phone,
//     required this.website,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return LocationSingleCardWrapper(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             LocaleKeys.contacts.tr(),
//             style: context.textTheme.headlineLarge,
//           ),
//           const SizedBox(height: 8),
//           ContactsCardRow(
//             icon: AppIcons.phoneFill,
//             value: phone,
//             hint: LocaleKeys.show_phone_number.tr(),
//           ),
//           const SizedBox(height: 16),
//           ContactsCardRow(
//             icon: AppIcons.globe,
//             value: website,
//             hint: LocaleKeys.show_web_address.tr(),
//           ),
//           const SizedBox(height: 16),
//           ContactsCardRow(
//             icon: AppIcons.sms,
//             value: email,
//             hint: LocaleKeys.show_web_address.tr(),
//           ),
//           const SizedBox(height: 16),
//           const Divider(
//             color: aliceBlue,
//             height: 1,
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               WScaleAnimation(
//                 onTap: () {},
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: ghostWhite,
//                   ),
//                   child: SvgPicture.asset(AppIcons.telegram, width: 20, height: 20),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               WScaleAnimation(
//                 onTap: () {},
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: ghostWhite,
//                   ),
//                   child: SvgPicture.asset(AppIcons.x, width: 20, height: 20),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               WScaleAnimation(
//                 onTap: () {},
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: ghostWhite,
//                   ),
//                   child: SvgPicture.asset(AppIcons.youtube, width: 20, height: 20),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               WScaleAnimation(
//                 onTap: () {},
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: ghostWhite,
//                   ),
//                   child: SvgPicture.asset(AppIcons.instagram, width: 20, height: 20),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
