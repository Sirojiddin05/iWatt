import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/charge_location_single_bloc/charge_location_single_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/charging_stations_bottom_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/present_sheet_header.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

import 'connector_card.dart';

class StationSingleSheet extends StatefulWidget {
  const StationSingleSheet({super.key});

  @override
  State<StationSingleSheet> createState() => _StationSingleSheetState();
}

class _StationSingleSheetState extends State<StationSingleSheet> {
  late CarouselController carouselController;
  late ValueNotifier<int> carouselIndex;

  @override
  void initState() {
    carouselController = CarouselController();
    carouselIndex = ValueNotifier(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChargeLocationSingleBloc, ChargeLocationSingleState>(
      listenWhen: (o, n) => o.selectedStationIndex != n.selectedStationIndex,
      listener: (context, state) {
        carouselController.animateToPage(state.selectedStationIndex);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: PresentSheetHeader(
              title: LocaleKeys.charging_stations.tr(),
              titleFotSize: 18,
              hasCloseIcon: true,
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
                      Positioned.fill(
                        child: BlocBuilder<ChargeLocationSingleBloc, ChargeLocationSingleState>(
                          builder: (ctx, state) {
                            return CarouselSlider(
                              carouselController: carouselController,
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  carouselIndex.value = index;
                                },
                                height: 464,
                                enableInfiniteScroll: false,
                                viewportFraction: .6,
                                disableCenter: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                                enlargeCenterPage: true,
                                enlargeFactor: .5,
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
                                      );
                                    }),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      // Positioned.fill(
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             carouselController.previousPage();
                      //           },
                      //           child: Container(
                      //             height: 450,
                      //             decoration: BoxDecoration(
                      //               gradient: LinearGradient(
                      //                 begin: Alignment.centerLeft,
                      //                 end: Alignment.centerRight,
                      //                 colors: [
                      //                   AppColors.solitude.withOpacity(.8),
                      //                   AppColors.solitude.withOpacity(0),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(width: 200),
                      //       Expanded(
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             carouselController.nextPage();
                      //           },
                      //           child: Container(
                      //             height: 450,
                      //             decoration: BoxDecoration(
                      //               gradient: LinearGradient(
                      //                 begin: Alignment.centerRight,
                      //                 end: Alignment.centerLeft,
                      //                 colors: [
                      //                   AppColors.solitude.withOpacity(.8),
                      //                   AppColors.solitude.withOpacity(0),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const ChargingStationsBottomWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
