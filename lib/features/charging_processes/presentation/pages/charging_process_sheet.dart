import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/charging_process_bloc/charging_process_bloc.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charger_info_w.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charging_car_animation_widget.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/grid_Info_cards_widget.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/max_power_and_price_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/common_loader_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/present_sheet_header.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ChargingProcessSheet extends StatefulWidget {
  final ConnectorEntity connector;
  final String locationName;

  const ChargingProcessSheet({super.key, required this.connector, required this.locationName});

  @override
  State<ChargingProcessSheet> createState() => _ChargingProcessSheetState();
}

class _ChargingProcessSheetState extends State<ChargingProcessSheet> {
  // late final String priceConnector;
  // late final String priceWaiting;
  // late final String priceParking;
  late final int processIndex;

  @override
  void initState() {
    super.initState();
    // final connectorPrice = widget.connector.price;
    // priceConnector = "${MyFunctions.formatNumber(connectorPrice.priceConnector.toString())} ${connectorPrice.priceType}";
    // priceWaiting = "${MyFunctions.formatNumber(connectorPrice.priceWaiting.toString())} ${connectorPrice.priceWaitingType}";
    // priceParking = "${MyFunctions.formatNumber(connectorPrice.priceParking.toString())} ${connectorPrice.priceParkingType}";
    final processes = context.read<ChargingProcessBloc>().state.processes;
    for (int i = 0; i < processes.length; i++) {
      final process = processes[i];
      if (process.connector.id == widget.connector.id) {
        processIndex = i;
        break;
      }
    }
  }

  @override
  void deactivate() {
    // final state = context.read<ChargingProcessBloc>().state;
    // final process = state.processes[processIndex];
    // if (!process.running) {
    //   context.read<ChargingProcessBloc>().add(DeleteProcessEvent(processConnectorId: process.connector.id));
    // }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PresentSheetHeader(
            title: LocaleKeys.charing.tr(),
            titleFotSize: 18,
            paddingOfCloseIcon: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            onCloseTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(color: context.theme.dividerColor, thickness: 1, height: 1),
          const SizedBox(height: 16),
          MaxPowerAndPriceWidget(
            maxPower: widget.connector.maxPower.toString(),
            price: MyFunctions.formatNumber(
              widget.connector.price.toString().split('.').first,
            ),
          ),
          const SizedBox(height: 12),
          ChargerInfoWidget(
            address: widget.locationName,
            cost: MyFunctions.formatNumber(
              widget.connector.parkingPrice.toString().split('.').first,
            ),
          ),
          BlocConsumer<ChargingProcessBloc, ChargingProcessState>(
            listenWhen: (o, n) {
              return o.stopProcessStatus != n.stopProcessStatus;
            },
            listener: (ctx, state) {
              if (state.stopProcessStatus.isFailure) {
                Navigator.pop(context);
                context.showPopUp(
                  context,
                  PopUpStatus.failure,
                  message: state.stopProcessErrorMessage,
                );
              } else if (state.stopProcessStatus.isInProgress) {
                showCommonLoaderDialog(context);
              } else if (state.stopProcessStatus.isSuccess) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state.processes.isEmpty || state.processes[processIndex].connector.id != widget.connector.id) {
                Navigator.of(context).pop();
                return const SizedBox.expand();
              }
              final process = state.processes[processIndex];
              final meterValue = process.meterValueMessage;
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.baliHai.withOpacity(0.12),
                        blurRadius: 32,
                        offset: const Offset(0, -6),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: NotificationListener(
                          onNotification: (OverscrollIndicatorNotification notification) {
                            notification.disallowIndicator();
                            return false;
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.plugRight,
                                      width: 16,
                                      height: 16,
                                      color: meterValue.batteryPercent == -1 ? AppColors.brightSun : AppColors.limeGreen,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      meterValue.batteryPercent == -1
                                          ? LocaleKeys.charging_is_starting.tr()
                                          : meterValue.batteryPercent == 100
                                              ? LocaleKeys.charging_is_ended.tr()
                                              : LocaleKeys.charging.tr(),
                                      style: context.textTheme.headlineLarge!.copyWith(fontSize: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                // if(meterValue.vin)...{
                                //   Text("VIN: 1HGCM82633A004352", style: context.textTheme.titleLarge!.copyWith(color: taxBreak)),
                                //
                                // }
                                const SizedBox(height: 22),
                                ChargingCarAnimationWidget(
                                  percentage: meterValue.batteryPercent,
                                  scale: 1.1,
                                ),
                                const SizedBox(height: 20),
                                GridInfoCardsWidget(
                                  currentPower: '${meterValue.batteryPercent} %',
                                  timeLeft: "-",
                                  charged: "${meterValue.consumedKwh} ${LocaleKeys.kW.tr()}",
                                  paid: meterValue.money.isEmpty ? '-' : "${meterValue.money} ${LocaleKeys.sum.tr()}",
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ),
                      WButton(
                        onTap: () {
                          showCustomAdaptiveDialog(
                            context,
                            title: LocaleKeys.stop_charging.tr(),
                            description: LocaleKeys.with_this_action_you_stop_charging.tr(),
                            confirmText: LocaleKeys.finish.tr(),
                            onConfirm: () {
                              context.read<ChargingProcessBloc>().add(StopChargingProcessEvent(transactionId: meterValue.transactionId));
                            },
                          );
                        },
                        height: 44,
                        margin: EdgeInsets.fromLTRB(16, 16, 16, context.padding.bottom + 16),
                        color: AppColors.amaranth.withOpacity(0.1),
                        // isLoading: state.finishProcessStatus.isInProgress,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.stopCharging),
                            const SizedBox(width: 6),
                            Text(
                              LocaleKeys.stop_charging.tr(),
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontSize: 15,
                                    color: AppColors.amaranth,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // ColoredBox(
          //   color: white,
          //   child: AnimatedCrossFade(
          //     firstChild: WButton(
          //       onTap: () {
          //         if (process.connectorStatus == 'Preparing') {
          //           // context.read<ChargingProcessBloc>().add(
          //           //       CreateTaskEvent(
          //           //         onError: (message) {
          //           //           context
          //           //               .showPopUp(
          //           //             status: PopUpStatus.error,
          //           //             context: context,
          //           //             message: message,
          //           //           )
          //           //               .then((value) {
          //           //             showModalBottomSheet(
          //           //               context: context,
          //           //               isScrollControlled: true,
          //           //               isDismissible: true,
          //           //               useRootNavigator: true,
          //           //               backgroundColor: Colors.transparent,
          //           //               builder: (ctx) {
          //           //                 return NotHaveEnoughMoneySheet(
          //           //                   onTopUp: () {
          //           //                     Navigator.pop(ctx);
          //           //                     showCupertinoModalBottomSheet(
          //           //                       context: context,
          //           //                       useRootNavigator: true,
          //           //                       builder: (BuildContext context) {
          //           //                         return const TopUpBottomSheet();
          //           //                       },
          //           //                     ).then((value) => context.read<LoginBloc>().add(GetUserDataEvent()));
          //           //                   },
          //           //                   errorMessage: message,
          //           //                 );
          //           //               },
          //           //             );
          //           //           });
          //           //         },
          //           //         processConnectorId: process.connector.id,
          //           //         carId: process.carId,
          //           //       ),
          //           //     );
          //         } else {
          //           // context.read<ChargingProcessBloc>().add(GetConnectorStatusOnceEvent(
          //           //     chargePointId: process.connector.chargePoint, connectorId: process.connector.id, locationId: process.locationId));
          //         }
          //       },
          //       height: 44,
          //       color: process.isLoadingWhenDisabled || process.isTappableForGettingConnectorStatus ? geyser.withOpacity(0.4) : mainButtonColor,
          //       rippleColor: process.isLoadingWhenDisabled || process.isTappableForGettingConnectorStatus ? Colors.transparent : white.withAlpha(50),
          //       margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          //       disabledColor: geyser.withOpacity(0.4),
          //       textColor: process.isLoadingWhenDisabled || process.isTappableForGettingConnectorStatus ? geyser : white,
          //       text: LocaleKeys.start.tr(),
          //       // isDisabled: process.connectorStatus != 'Preparing' && process.isLoadingWhenDisabled,
          //       // isLoading: state.startProcessStatus.isInProgress || process.isLoadingWhenDisabled,
          //       scaleValue: process.connectorStatus != 'Preparing' ? 1 : 0.95,
          //       loadingWidget: CupertinoActivityIndicator(color: process.isLoadingWhenDisabled ? geyser : white),
          //     ),
          //
          //     /// TODO: show orange info container
          //     // firstChild: const InfoContainer(
          //     //   infoText: "Процесс зардяки закончился, отсоедините свой автомобиль от станции",
          //     //   color: bookedColor,
          //     //   margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
          //     // ),
          //
          //     /// TODO: show red info container
          //     // firstChild: InfoContainer(
          //     //   infoText: "Мало средств. Пополните карту или выберите другую карту!",
          //     //   color: red,
          //     //   margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
          //     //   suffix: WButton(
          //     //     height: 32,
          //     //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          //     //     text: LocaleKeys.top_up.tr(),
          //     //     textStyle: context.textTheme.labelLarge!.copyWith(color: white),
          //     //     rippleColor: cyprus.withAlpha(50),
          //     //     color: cyprus,
          //     //     onTap: () {},
          //     //   ),
          //     // ),
          //     secondChild: WButton(
          //       onTap: () {
          //         showModalBottomSheet(
          //           backgroundColor: Colors.transparent,
          //           context: context,
          //           builder: (ctx) {
          //             return process.taskStatus.transaction.soc == 100
          //                 ? FinishedChargingSheet(
          //                     onTap: () {
          //                       // context.read<ChargingProcessBloc>().add(
          //                       //       FinishChargingProcessEvent(
          //                       //         transactionId: process.taskStatus.transaction.id,
          //                       //         onSuccess: () {
          //                       //           Navigator.of(ctx).pop();
          //                       //           Navigator.of(context).pop();
          //                       //           showCupertinoModalBottomSheet(
          //                       //             context: context,
          //                       //             isDismissible: false,
          //                       //             useRootNavigator: true,
          //                       //             builder: (ctx) {
          //                       //               return ChargingPaymentCheck(
          //                       //                 id: process.connector.id,
          //                       //                 timeStamp: process.taskStatus.transaction.startTimestamp,
          //                       //               );
          //                       //             },
          //                       //           ).then((value) => widget.onDelete(process.connector.id));
          //                       //         },
          //                       //       ),
          //                       //     );
          //                     },
          //                   )
          //                 : FinishingChargingSheet(
          //                     percent: process.taskStatus.transaction.soc.toInt(),
          //                     onFinish: () {
          //                       // context.read<ChargingProcessBloc>().add(FinishChargingProcessEvent(
          //                       //     transactionId: process.taskStatus.transaction.id,
          //                       //     onSuccess: () {
          //                       //       Navigator.of(ctx).pop();
          //                       //       Navigator.of(context).pop();
          //                       //       showCupertinoModalBottomSheet(
          //                       //         context: context,
          //                       //         isDismissible: false,
          //                       //         useRootNavigator: true,
          //                       //         builder: (ctx) {
          //                       //           return ChargingPaymentCheck(
          //                       //             id: process.connector.id,
          //                       //             timeStamp: process.taskStatus.transaction.startTimestamp,
          //                       //           );
          //                       //         },
          //                       //       ).then((value) => widget.onDelete(process.connector.id));
          //                       //     }));
          //                     },
          //                     // isLoading: state.finishProcessStatus.isInProgress,
          //                     isLoading: false,
          //                   );
          //           },
          //         );
          //       },
          //       height: 44,
          //       margin: const EdgeInsets.all(16),
          //       color: process.taskStatus.transaction.soc == 100 ? brightBlue : red,
          //       // isLoading: state.finishProcessStatus.isInProgress,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             LocaleKeys.finish.tr(),
          //             style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16, color: white),
          //           ),
          //           const SizedBox(width: 8),
          //           SvgPicture.asset(AppIcons.endFlag, color: white),
          //         ],
          //       ),
          //     ),
          //     crossFadeState: process.running ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          //     duration: const Duration(milliseconds: 200),
          //     //   );
          //     // },
          //   ),
          // ),
        ],
      ),
    );
  }
}
