import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class FilterCategoryTitle extends StatelessWidget {
  final String title;
  const FilterCategoryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.displaySmall,
    );
  }
}
