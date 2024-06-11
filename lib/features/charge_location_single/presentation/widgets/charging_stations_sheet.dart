import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/charge_location_single_bloc/charge_location_single_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/charging_stations_bottom_widget.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/station_background.dart';
import 'package:i_watt_app/features/common/presentation/widgets/present_sheet_header.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

import 'connector_card.dart';

class StationSingleSheet extends StatelessWidget {
  final VoidCallback onClose;
  final CarouselController carouselController;
  const StationSingleSheet({super.key, required this.onClose, required this.carouselController});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (isTrue) {
        onClose();
      },
      child: Container(
        margin: EdgeInsets.only(top: MediaQueryData.fromView(View.of(context)).padding.top),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.white,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: PresentSheetHeader(
                title: LocaleKeys.charging_stations.tr(),
                titleFotSize: 18,
                hasCloseIcon: true,
                onCloseTap: onClose,
                paddingOfCloseIcon: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              ),
            ),
            Divider(color: context.theme.dividerColor, thickness: 1, height: 1),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        const StationBackgroundImage(),
                        Positioned.fill(
                          child: BlocBuilder<ChargeLocationSingleBloc, ChargeLocationSingleState>(
                            builder: (ctx, state) {
                              return CarouselSlider(
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    if (reason == CarouselPageChangedReason.manual) {
                                      context.read<ChargeLocationSingleBloc>().add(ChangeSelectedStationIndex(index));
                                    }
                                  },
                                  height: 464,
                                  enableInfiniteScroll: false,
                                  viewportFraction: .6,
                                  disableCenter: true,
                                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                                  enlargeCenterPage: true,
                                  enlargeFactor: .5,
                                  initialPage: state.selectedStationIndex,
                                ),
                                items: List.generate(
                                  state.location.chargers.length,
                                  (stationIndex) {
                                    final station = state.location.chargers[stationIndex];
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(station.connectors.length, (connectorIndex) {
                                        final connector = station.connectors[connectorIndex];
                                        return ConnectorCard(
                                          connector: connector,
                                          price: station.price,
                                          isNearToStation: state.isNearToStation,
                                          locationName: '${state.location.vendor.name} "${state.location.name}"',
                                        );
                                      }),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ChargingStationsBottomWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
