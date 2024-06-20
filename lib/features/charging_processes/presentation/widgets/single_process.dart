import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/charging_process_status.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/charging_process_entity.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/charging_process_bloc/charging_process_bloc.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charger_info_w.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charging_car_animation_widget.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/grid_Info_cards_widget.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/max_power_and_price_widget.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/parking_card.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/common_loader_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/info_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class SingleProcess extends StatefulWidget {
  final ConnectorEntity connector;
  final String locationName;
  const SingleProcess({super.key, required this.connector, required this.locationName});

  @override
  State<SingleProcess> createState() => _SingleProcessState();
}

class _SingleProcessState extends State<SingleProcess> {
  late final int processIndex;

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        MaxPowerAndPriceWidget(
          maxPower: widget.connector.maxElectricPower.toString(),
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
              Navigator.pop(ctx);
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
              return const SizedBox.expand();
            }
            final process = state.processes[processIndex];
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
                                    color: process.batteryPercent == -1 ? AppColors.brightSun : AppColors.limeGreen,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    getTitleText(process),
                                    style: context.textTheme.headlineLarge!.copyWith(fontSize: 18),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // if(meterValue.vin)...{
                              //   Text("VIN: 1HGCM82633A004352", style: context.textTheme.titleLarge!.copyWith(color: taxBreak)),
                              //
                              // }
                              const SizedBox(height: 40),
                              ChargingCarAnimationWidget(
                                percentage: process.batteryPercent,
                              ),
                              const SizedBox(height: 20),
                              GridInfoCardsWidget(
                                currentPower: '${process.currentKwh} ${LocaleKeys.kW.tr()}',
                                timeLeft: process.estimatedTime,
                                charged: "${process.consumedKwh} ${LocaleKeys.kW.tr()}",
                                paid: process.money.isEmpty ? '-' : "${process.money} ${LocaleKeys.sum.tr()}",
                              ),
                              const SizedBox(height: 12),
                              if (process.status == ChargingProcessStatus.PARKING.name) ...{
                                ParkingCard(
                                  parkingPrice: MyFunctions.formatNumber(process.payedParkingPrice.toString()),
                                  payedParkingLasts: process.payedParkingLasts,
                                  payedParkingWillStartAfter: process.payedParkingWillStartAfter,
                                  isPayedPeriodStarted: process.isPayedParkingStarted,
                                ),
                              }
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: WButton(
                        onTap: () {
                          showCustomAdaptiveDialog(
                            context,
                            title: LocaleKeys.stop_charging.tr(),
                            description: LocaleKeys.with_this_action_you_stop_charging.tr(),
                            confirmText: LocaleKeys.finish.tr(),
                            onConfirm: () {
                              context.read<ChargingProcessBloc>().add(StopChargingProcessEvent(transactionId: process.transactionId));
                            },
                          );
                        },
                        height: 44,
                        margin: EdgeInsets.fromLTRB(16, 16, 16, context.padding.bottom + 16),
                        color: AppColors.amaranth.withOpacity(0.1),
                        rippleColor: AppColors.amaranth.withAlpha(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.stopCharging),
                            const SizedBox(width: 6),
                            Text(
                              LocaleKeys.stop_charging.tr(),
                              style: context.textTheme.headlineLarge?.copyWith(
                                fontSize: 15,
                                color: AppColors.amaranth,
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondChild: InfoContainer(
                        infoText: LocaleKeys.parking_is_over_disconnect_connector.tr(),
                        color: AppColors.brightSun3.withOpacity(0.16),
                        iconColor: AppColors.brightSun3,
                        margin: EdgeInsets.fromLTRB(16, 8, 16, context.padding.bottom + 16),
                      ),
                      crossFadeState: process.status == ChargingProcessStatus.PARKING.name ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: AppConstants.animationDuration,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String getTitleText(ChargingProcessEntity process) {
    if (process.freeParkingMinutes != -1) {
      return LocaleKeys.pause.tr();
    } else if (process.batteryPercent == -1) {
      return LocaleKeys.charging_is_starting.tr();
    } else if (process.batteryPercent == 100) {
      return LocaleKeys.charging_is_ended.tr();
    }
    return LocaleKeys.charging.tr();
  }
}
