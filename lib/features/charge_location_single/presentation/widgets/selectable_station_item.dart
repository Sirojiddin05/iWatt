import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_radio.dart';

class SelectableStationItem extends StatelessWidget {
  final int value;
  final int groupValue;
  final String title;
  final Function() onTap;
  final List<ConnectorEntity> connectors;
  const SelectableStationItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onTap,
    required this.connectors,
  });

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      rippleColor: AppColors.primaryRipple30,
      onTap: onTap,
      borderRadius: BorderRadius.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            WRadio(
              onChanged: (value) {},
              value: value,
              groupValue: groupValue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodySmall,
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: List.generate(
                connectors.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: SvgPicture.network(
                    connectors[index].standard.icon,
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
