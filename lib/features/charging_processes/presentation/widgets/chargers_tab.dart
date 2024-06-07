import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ChargersTab extends StatelessWidget {
  final TabController tabController;
  const ChargersTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.solitude,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 15),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(0),
        controller: tabController,
        indicator: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff083624).withOpacity(0.04),
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: const Color(0xff083624).withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        tabs: [
          Padding(padding: const EdgeInsets.all(6), child: Text(LocaleKeys.in_process.tr())),
          Padding(padding: const EdgeInsets.all(6), child: Text(LocaleKeys.history.tr())),
        ],
        dividerHeight: 0,
        labelColor: AppColors.cyprus,
        unselectedLabelColor: AppColors.taxBreak,
        labelStyle: context.textTheme.bodySmall?.copyWith(fontSize: 13),
        unselectedLabelStyle: context.textTheme.titleLarge?.copyWith(fontSize: 13),
      ),
    );
  }
}
