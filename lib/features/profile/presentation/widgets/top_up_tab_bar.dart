import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:k_watt_app/assets/colors/colors.dart';
import 'package:k_watt_app/generated/locale_keys.g.dart';

class TopUpTabBar extends StatelessWidget {
  final TabController tabController;
  const TopUpTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lilyWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(2),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        controller: tabController,
        labelPadding: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(2),
        indicator: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(6),
        ),
        indicatorColor: Colors.transparent,
        unselectedLabelColor: rollingStone,
        labelColor: mainTextColor,
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 13),
        unselectedLabelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 13),
        tabs: [
          Text(
            LocaleKeys.payment_systems.tr(),
          ),
          Text(
            LocaleKeys.via_card.tr(),
          ),
        ],
      ),
    );
  }
}
