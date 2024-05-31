import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_container.dart';

class DraggableHead extends StatelessWidget {
  final ValueNotifier<double> dragStickTop;

  const DraggableHead({super.key, required this.dragStickTop});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dragStickTop,
      builder: (context, value, child) {
        return Positioned(
          top: value + 8,
          left: 0,
          right: 0,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SheetHeadContainer(
                margin: EdgeInsets.zero,
              ),
            ],
          ),
        );
      },
    );
  }
}
