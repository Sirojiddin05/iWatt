import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_highlighted_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';
import 'package:i_watt_app/features/list/presentation/widgets/location_card_data_row.dart';
import 'package:i_watt_app/features/list/presentation/widgets/location_connector_statuses_widget.dart';
import 'package:i_watt_app/features/list/presentation/widgets/location_data_divider_circle.dart';

class ChargeLocationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String highlightedTitle;
  final List<String> powerTypes;
  final String? distanceValue;
  final int locationId;
  final int stationsCount;
  final List<ConnectorStatus> connectorStatuses;
  final VoidCallback onTap;
  final String logo;

  const ChargeLocationCard({
    super.key,
    required this.title,
    required this.highlightedTitle,
    required this.subtitle,
    required this.powerTypes,
    required this.distanceValue,
    required this.locationId,
    required this.stationsCount,
    required this.connectorStatuses,
    required this.onTap,
    required this.logo,
  });

  String getFirstThatNotEmpty(List<List<String>> stations) {
    for (final station in stations) {
      for (final power in station) {
        if (power.isNotEmpty) {
          return power.replaceAll(' ', '');
        }
      }
    }

    return '';
  }

  List<String> getList(List<List<String>> stations) {
    final List<String> list = [];
    for (final station in stations) {
      for (final power in station) {
        list.add(power.replaceAll(' ', ''));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: onTap,
      rippleColor: context.theme.splashColor,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 6,
              spreadRadius: 0,
              color: AppColors.black.withOpacity(.05),
            ),
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 0,
              spreadRadius: 1,
              color: AppColors.black.withOpacity(.05),
            ),
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 0,
              spreadRadius: 1,
              color: AppColors.black.withOpacity(.05),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocationStatusesWidget(connectorStatuses: connectorStatuses),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HighlightedText(
                        allText: title,
                        highlightedText: highlightedTitle,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      WImage(width: 76, height: 18, imageUrl: logo),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 1,
              decoration: BoxDecoration(color: context.theme.dividerColor),
              margin: const EdgeInsets.only(bottom: 8),
            ),
            Row(
              children: [
                LocationCardDataRow(
                  icon: context.themedIcons.power,
                  value: powerTypes.take(2).join(', '),
                ),
                const LocationDataDividerCircle(),
                LocationCardDataRow(
                  icon: context.themedIcons.station,
                  value: "$stationsCount ${MyFunctions.getStationDueToQuantity(stationsCount).tr()}",
                ),
                if (distanceValue != null && distanceValue!.isNotEmpty) ...{
                  const LocationDataDividerCircle(),
                  LocationCardDataRow(
                    icon: context.themedIcons.runner,
                    value: distanceValue!,
                  ),
                }
              ],
            )
          ],
        ),
      ),
    );
  }
}
