// import 'package:flutter/material.dart';
//
// class ChargingPointsCardLoader extends StatelessWidget {
//   const ChargingPointsCardLoader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return LocationSingleCardWrapper(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           for (int i = 0; i < 4; i++) ...{
//             if (i != 0) const Divider(color: ghostWhite, height: 16, indent: 44),
//             const FittedBox(
//               child: Row(
//                 children: [
//                   ShimmerWidget(height: 36, width: 36, color: divider2),
//                   SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ShimmerWidget(height: 16, width: 114, color: divider2),
//                       SizedBox(height: 4),
//                       ShimmerWidget(height: 12, width: 55, color: divider2),
//                     ],
//                   ),
//                   SizedBox(width: 24),
//                   ShimmerWidget(height: 24, width: 70, color: divider2),
//                   SizedBox(width: 8),
//                   ShimmerWidget(height: 16, width: 55, color: divider2),
//                 ],
//               ),
//             ),
//           }
//         ],
//       ),
//     );
//   }
// }
