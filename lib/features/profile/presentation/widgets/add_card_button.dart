import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_card_bottom_sheet.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class AddCardButton extends StatelessWidget {
  const AddCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: context.theme.primaryColor.withOpacity(.2),
      strokeWidth: 1,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: EdgeInsets.zero,
      dashPattern: const [18, 8],
      child: WButton(
        textColor: context.theme.primaryColor,
        color: context.theme.primaryColor.withOpacity(.08),
        height: 60,
        onTap: () => showAddCardSheet(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppIcons.plus, color: context.theme.primaryColor),
            const SizedBox(width: 4),
            Text(LocaleKeys.add_card.tr()),
          ],
        ),
      ),
    );
  }
}
