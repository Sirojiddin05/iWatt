import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_close_button.dart';

class ModalSheetHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;

  const ModalSheetHeaderWidget({super.key, required this.title, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.displayMedium,
              ),
            ),
            SheetCloseButton(
              onTap: onClose ?? () => Navigator.pop(context),
            )
          ],
        ),
        Divider(
          color: context.theme.dividerColor,
          height: 1,
          thickness: 1,
        )
      ],
    );
  }
}
