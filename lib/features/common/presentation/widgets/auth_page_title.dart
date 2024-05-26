import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class AuthPageTitle extends StatelessWidget {
  final String title;
  const AuthPageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: context.textTheme.displayLarge?.copyWith(fontSize: 32),
        textAlign: TextAlign.left,
      ),
    );
  }
}
