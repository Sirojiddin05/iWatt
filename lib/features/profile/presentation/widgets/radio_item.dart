// import 'package:flutter/material.dart';
// import 'package:k_watt_app/assets/colors/colors.dart';
//
// class RadioCircle extends StatelessWidget {
//   final bool isSelected;
//   final double radius;
//   final double _width;
//   final double _height;
//
//   const RadioCircle({Key? key, required this.isSelected, required this.radius})
//       : _width = radius * 2,
//         _height = radius * 2,
//         // _selectedBorderWidth = radius / 2,
//         super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       height: _height,
//       width: _width,
//       duration: const Duration(milliseconds: 100),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(radius),
//         border: isSelected ? Border.all(width: 2, color: mainButtonColor) : Border.all(width: 1, color: geyser),
//       ),
//       child: AnimatedContainer(
//         margin: const EdgeInsets.all(3),
//         duration: const Duration(milliseconds: 100),
//         decoration: BoxDecoration(
//           color: isSelected ? mainButtonColor : Colors.transparent,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }
