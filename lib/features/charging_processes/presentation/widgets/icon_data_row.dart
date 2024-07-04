import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class IconDataRow extends StatelessWidget {
  const IconDataRow({
    super.key,
    required this.icon,
    required this.value,
  });

  final String icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 16, height: 16),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            getValue(),
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelLarge!.copyWith(color: context.themedColors.cyprusToWhite),
          ),
        )
      ],
    );
  }

  String getValue() {
    if (value.contains('-1') || value.contains('∞') || value.contains('-1.0')) {
      return '-';
    }
    return value;
  }
}
