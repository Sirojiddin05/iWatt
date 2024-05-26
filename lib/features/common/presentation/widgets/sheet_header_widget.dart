import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_close_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_title.dart';

class SheetHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;
  const SheetHeaderWidget({
    super.key,
    required this.title,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(alignment: Alignment.center, child: SheetHeadContainer()),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SheetTitleText(title: title),
            const Spacer(),
            SheetCloseButton(
              onTap: onClose ?? () => Navigator.of(context).pop(),
            ),
          ],
        ),
        Divider(color: context.theme.dividerColor, height: 0, thickness: 1),
      ],
    );
  }
}
