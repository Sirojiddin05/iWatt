import 'package:flutter/material.dart';

class FilterCategoryTitle extends StatelessWidget {
  final String title;
  const FilterCategoryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
