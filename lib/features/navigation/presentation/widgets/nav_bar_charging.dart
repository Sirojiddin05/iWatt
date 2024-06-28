import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/charging_process_entity.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class NavBarCharging extends StatelessWidget {
  final List<ChargingProcessEntity> processes;
  final int currentIndex = 2;
  const NavBarCharging({super.key, required this.processes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: context.padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Stack(
          //   children: [
          //
          //   ],
          // ),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                LocaleKeys.charging.tr(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: currentIndex == 2
                    ? context.theme.bottomNavigationBarTheme.selectedLabelStyle
                    : context.theme.bottomNavigationBarTheme.unselectedLabelStyle,
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
