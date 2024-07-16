import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/charger_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/charge_location_single_bloc/charge_location_single_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/connector_status_container.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_card_wrapper.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/not_integrated_bottom_sheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ConnectorsCard extends StatefulWidget {
  final bool isIntegrated;
  final List<ChargerEntity> chargers;
  final VoidCallback onTap;
  final String locationName;
  final String locationAddress;
  final String distance;
  final String vendorName;
  final String vendorLogo;
  final String organizationName;
  final String appStoreUrl;
  final String playMarketUrl;
  final String appName;

  const ConnectorsCard({
    super.key,
    required this.chargers,
    required this.onTap,
    required this.isIntegrated,
    required this.locationName,
    required this.locationAddress,
    required this.distance,
    required this.vendorName,
    required this.vendorLogo,
    required this.organizationName,
    required this.appStoreUrl,
    required this.playMarketUrl,
    required this.appName,
  });

  @override
  State<ConnectorsCard> createState() => _ConnectorsCardState();
}

class _ConnectorsCardState extends State<ConnectorsCard> {
  final List<ConnectorEntity> allConnectors = [];

  @override
  void initState() {
    super.initState();
    for (final charger in widget.chargers) {
      allConnectors.addAll(charger.connectors);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LocationSingleCardWrapper(
      padding: EdgeInsets.zero,
      child: Column(
        children: List.generate(
          allConnectors.length,
          (index) {
            return WCustomTappableButton(
              onTap: () {
                if (widget.isIntegrated) {
                  context
                      .read<ChargeLocationSingleBloc>()
                      .add(ChangeSelectedStationIndexByConnectorId(allConnectors[index].id));
                  widget.onTap();
                } else {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) => NotIntegratedBottomSheet(
                      locationName: widget.locationName,
                      locationAddress: widget.locationAddress,
                      distance: widget.distance,
                      vendorLogo: widget.vendorLogo,
                      vendorName: widget.vendorName,
                      organizationName: widget.organizationName,
                      appStoreUrl: widget.appStoreUrl,
                      playMarketUrl: widget.playMarketUrl,
                      appName: widget.appName,
                    ),
                  );
                }
              },
              borderRadius: getBorderRadius(index),
              rippleColor: AppColors.primaryRipple30,
              child: Padding(
                padding:
                    index == 0 ? const EdgeInsets.fromLTRB(16, 16, 12, 10) : const EdgeInsets.fromLTRB(16, 10, 12, 10),
                child: Row(
                  children: [
                    SvgPicture.network(
                      allConnectors[index].standard.icon,
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allConnectors[index].name,
                            style: context.textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${allConnectors[index].standard.maxVoltage} ${LocaleKeys.kW.tr()}',
                            style: context.textTheme.labelMedium!.copyWith(
                              color: AppColors.blueBayoux,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<ChargeLocationSingleBloc, ChargeLocationSingleState>(
                      buildWhen: (o, n) {
                        final oldAllConnectors = o.allConnectors;
                        final newAllConnectors = n.allConnectors;
                        return oldAllConnectors[index].status != newAllConnectors[index].status;
                      },
                      builder: (ctx, state) {
                        final status = ConnectorStatus.fromString(state.allConnectors[index].status);
                        return ConnectorStatusContainer(status: status);
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      getPrice(allConnectors[index].id),
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      "UZS",
                      style: context.textTheme.titleMedium!.copyWith(
                        color: AppColors.blueBayoux,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String getPrice(int id) {
    for (final charger in widget.chargers) {
      final connectorIds = List.generate(charger.connectors.length, (index) => charger.connectors[index].id);
      if (connectorIds.contains(id)) {
        return MyFunctions.formatNumber(charger.price.toString().split('.').first);
      }
    }
    return '';
  }

  BorderRadius getBorderRadius(index) {
    if (index == 0) {
      if (allConnectors.length != 1) {
        return const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );
      }
      return BorderRadius.circular(16);
    } else if (allConnectors.length - 1 == index) {
      return const BorderRadius.only(
        bottomRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      );
    }
    return BorderRadius.zero;
  }
}
