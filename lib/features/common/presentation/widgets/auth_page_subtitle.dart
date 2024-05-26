import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class AuthPageSubTitle extends StatelessWidget {
  final String subtitle;
  const AuthPageSubTitle({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        subtitle,
        style: context.textTheme.titleSmall,
        textAlign: TextAlign.left,
      ),
    );
  }
}
