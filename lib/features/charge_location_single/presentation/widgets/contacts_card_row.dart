import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class ContactsCardRow extends StatefulWidget {
  final String icon;
  final String value;
  final String hint;
  final VoidCallback onTap;

  const ContactsCardRow({
    super.key,
    required this.icon,
    required this.value,
    required this.hint,
    required this.onTap,
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: context.themedColors.solitudeToAliceBlueO4),
            child: SvgPicture.asset(
              widget.icon,
              color: context.themedColors.blueBayouxToWhite,
            ),
          ),
          const SizedBox(width: 12),
          Builder(builder: (ctx) {
            if (show) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.5),
                child: SelectableText(
                  widget.value,
                  style: context.textTheme.headlineMedium!.copyWith(color: context.themedColors.cyprusToWhite),
                  onTap: widget.onTap,
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.themedColors.solitudeToAliceBlueO4,
              ),
              child: Text(
                widget.hint,
                style: context.textTheme.headlineSmall!.copyWith(
                  fontSize: 13,
                  color: context.themedColors.prussianBlueToWhite,
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
