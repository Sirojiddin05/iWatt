import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_container.dart';

class SearchFilterList extends StatelessWidget {
  const SearchFilterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, context.padding.top + 16, 16, 0),
      child: const DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 40,
              spreadRadius: 0,
              color: AppColors.white,
            ),
          ],
        ),
        child: SearchFilterContainer(
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
