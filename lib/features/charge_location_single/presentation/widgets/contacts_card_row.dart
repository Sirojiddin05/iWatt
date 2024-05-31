import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ContactsCardRow extends StatefulWidget {
  final String icon;
  final String value;
  final String hint;
  const ContactsCardRow({
    super.key,
    required this.icon,
    required this.value,
    required this.hint,
  });

  @override
  State<ContactsCardRow> createState() => _ContactsCardRowState();
}

class _ContactsCardRowState extends State<ContactsCardRow> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!show) setState(() => show = true);
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.solitude),
            child: SvgPicture.asset(widget.icon),
          ),
          const SizedBox(width: 12),
          Builder(builder: (ctx) {
            if (show) {
              return SelectableText(
                widget.value,
                style: context.textTheme.headlineMedium!.copyWith(color: AppColors.cyprus),
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: widget.value));
                  context.showPopUp(
                    context,
                    PopUpStatus.success,
                    message: LocaleKeys.copied_to_clipboard.tr(),
                  );
                },
              );
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.aliceBlue,
              ),
              child: Text(
                widget.hint,
                style: context.textTheme.headlineSmall!.copyWith(
                  fontSize: 13,
                  color: AppColors.prussianBlue,
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
