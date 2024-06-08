// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:i_watt_app/core/config/app_icons.dart';
// import 'package:i_watt_app/core/util/my_functions.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/radio_item.dart';
//
// class SelectableUserCard extends StatelessWidget {
//   final VoidCallback onTap;
//   final bool isSelected;
//   final String number;
//   final String bankName;
//   const SelectableUserCard({super.key, required this.onTap, required this.isSelected, required this.number, required this.bankName});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(color: AppColorwhite, borderRadius: BorderRadius.circular(12), boxShadow: [
//           BoxShadow(
//             offset: const Offset(0, 6),
//             spreadRadius: 0,
//             blurRadius: 32,
//             color: baliHai.withOpacity(.16),
//           ),
//         ]),
//         child: Row(
//           children: [
//             SvgPicture.asset(number.substring(0, 4).contains("8600") ? AppIcons.uzcard : AppIcons.humo),
//             const SizedBox(width: 12),
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(number, style: Theme.of(context).textTheme.headlineSmall),
//               const SizedBox(height: 2),
//               Text(bankName, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12))
//             ]),
//             const Spacer(),
//             RadioCircle(isSelected: isSelected, radius: 12)
//           ],
//         ),
//       ),
//     );
//   }
// }
