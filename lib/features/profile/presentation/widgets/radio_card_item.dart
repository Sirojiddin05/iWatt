// import 'package:flutter/material.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/radio_item.dart';
// import 'package:k_watt_app/assets/colors/colors.dart';
// import 'package:k_watt_app/features/common/presentation/widgets/radio_item.dart';
//
// class RadioCardItem extends StatelessWidget {
//   final ValueChanged<String> onTap;
//   final String value;
//   final String groupValue;
//   final String icon;
//
//   final bool isDisable;
//
//   const RadioCardItem({
//     required this.onTap,
//     required this.groupValue,
//     required this.isDisable,
//     required this.value,
//     Key? key,
//     required this.icon,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: isDisable ? () {} : () => onTap(value),
//       child: Container(
//         height: 44,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: isDisable ? dark.withOpacity(0.1) : lilyWhite1,
//           border: Border.all(color: value == groupValue ? mainButtonColor : mainColor.withOpacity(.16), width: 1),
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: value == groupValue
//               ? [
//                   BoxShadow(color: brightBlue.withOpacity(.012), blurRadius: 16, spreadRadius: 0, offset: const Offset(0, 0)),
//                 ]
//               : null,
//         ),
//         padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
//         child: Row(
//           children: [
//             RadioCircle(isSelected: value == groupValue, radius: 10),
//             const SizedBox(width: 10),
//             SizedBox(height: 20, child: Image.asset(icon))
//           ],
//         ),
//       ),
//     );
//   }
// }
