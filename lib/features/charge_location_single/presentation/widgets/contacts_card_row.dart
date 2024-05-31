// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:i_watt_inapp/assets/colors/colors.dart';
// import 'package:i_watt_inapp/utils/extensions.dart';
//
// class ContactsCardRow extends StatefulWidget {
//   final String icon;
//   final String value;
//   final String hint;
//   const ContactsCardRow({
//     super.key,
//     required this.icon,
//     required this.value,
//     required this.hint,
//   });
//
//   @override
//   State<ContactsCardRow> createState() => _ContactsCardRowState();
// }
//
// class _ContactsCardRowState extends State<ContactsCardRow> {
//   bool show = false;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (!show) setState(() => show = true);
//       },
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(6),
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ghostWhite),
//             child: SvgPicture.asset(widget.icon),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: show
//                 ? Text(widget.value, style: context.textTheme.headlineMedium!.copyWith(color: cyprus))
//                 : Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: aliceBlue),
//                     child: Text(widget.hint,
//                         style: context.textTheme.headlineSmall!.copyWith(fontSize: 13, color: prussianBlue)),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
