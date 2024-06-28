import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/saved_icon_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_highlighted_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/presentation/widgets/location_card_data_row.dart';
import 'package:i_watt_app/features/list/presentation/widgets/location_connector_statuses_widget.dart';
import 'package:i_watt_app/features/list/presentation/widgets/location_data_divider_circle.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ChargeLocationCard extends StatelessWidget {
  final ChargeLocationEntity location;
  final String highlightedTitle;
  final VoidCallback onTap;
  final bool hasSavedIcon;

  const ChargeLocationCard({
    super.key,
    this.highlightedTitle = '',
    this.hasSavedIcon = false,
    required this.location,
    required this.onTap,
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
        padding: EdgeInsets.fromLTRB(16, hasSavedIcon ? 0 : 16, hasSavedIcon ? 0 : 16, 8),
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
                Padding(
                  padding: EdgeInsets.only(top: hasSavedIcon ? 16 : 0),
                  child: LocationStatusesWidget(
                    connectorStatuses: List.generate(
                      location.connectorsStatus.length,
                      (index) {
                        final status = location.connectorsStatus[index];
                        return ConnectorStatus.fromString(status);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: hasSavedIcon ? 16 : 0),
                        child: HighlightedText(
                          allText: "${location.locationName} ${location.vendorName}",
                          highlightedText: highlightedTitle,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ),
                      if (location.logo.isNotEmpty) ...{
                        const SizedBox(height: 6),
                        WImage(
                          height: 20,
                          imageUrl: location.logo,
                          placeholder: const SizedBox(height: 20),
                        ),
                      }
                    ],
                  ),
                ),
                if (hasSavedIcon) ...{
                  SavedUnSaveButton(
                    location: location.copyWith(isFavorite: true),
                  ),
                },
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
                if (powerTypes.isNotEmpty) ...{
                  LocationCardDataRow(
                    icon: context.themedIcons.power,
                    value: powerTypes,
                  ),
                },
                if (powerTypes.isNotEmpty && location.chargersCount > 0) ...{
                  const LocationDataDividerCircle(),
                },
                if (location.chargersCount > 0) ...{
                  LocationCardDataRow(
                    icon: context.themedIcons.station,
                    value: "${location.chargersCount} ${MyFunctions.getStationDueToQuantity(location.chargersCount).tr()}",
                  ),
                },
                if ((location.chargersCount > 0 || powerTypes.isNotEmpty) && location.distance != -1) ...{
                  const LocationDataDividerCircle(),
                },
                if (location.distance != -1) ...{
                  LocationCardDataRow(
                    icon: context.themedIcons.runner,
                    value: distanceValue,
                  ),
                }
              ],
            )
          ],
        ),
      ),
    );
  }

  String get powerTypes {
    final powerTypes = location.maxElectricPowers.map((e) => '$e ${LocaleKeys.kW.tr()}').toList();
    return powerTypes.join(', ');
  }

  String get distanceValue {
    final distance = location.distance;
    return '${location.distance} ${LocaleKeys.km.tr()}';
  }
}
