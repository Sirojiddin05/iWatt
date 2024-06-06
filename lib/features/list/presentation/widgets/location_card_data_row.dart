import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class LocationCardDataRow extends StatelessWidget {
  final String icon;
  final String value;
  const LocationCardDataRow({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: context.textTheme.titleMedium?.copyWith(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
