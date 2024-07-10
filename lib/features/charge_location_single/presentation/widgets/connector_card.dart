import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/authorization/presentation/pages/sign_in.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/charging_process_bloc/charging_process_bloc.dart';
import 'package:i_watt_app/features/charging_processes/presentation/pages/charging_process_sheet.dart';
import 'package:i_watt_app/features/common/presentation/blocs/present_bottom_sheet/present_bottom_sheet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ConnectorCard extends StatelessWidget {
  final ConnectorEntity connector;
  final String price;
  final bool isNearToStation;
  final String locationName;
  final VoidCallback onClose;

  const ConnectorCard({
    super.key,
    required this.connector,
    required this.price,
    required this.isNearToStation,
    required this.locationName,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 104,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 6,
            color: AppColors.black.withOpacity(.05),
          ),
          BoxShadow(
            offset: const Offset(0, 1),
            spreadRadius: .5,
            color: AppColors.black.withOpacity(.05),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.stationActiveGradient.map((e) => e.withAlpha(200)).toList(),
                  ),
                ),
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.5),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppColors.stationActiveGradient,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 6),
                        color: AppColors.dodgerBlue.withOpacity(.3),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Text(
                    connector.name,
                    style: context.textTheme.displaySmall!.copyWith(color: AppColors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${connector.standard.maxVoltage} kW",
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelLarge!.copyWith(color: AppColors.blueBayoux),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${MyFunctions.formatNumber(price.split('.').first)} UZS',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.network(
                connector.standard.icon,
                width: 32,
                height: 32,
              )
            ],
          ),
          const Spacer(),
          IgnorePointer(
            ignoring: !(connector.status == 'Preparing' && isNearToStation),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
                return BlocConsumer<ChargingProcessBloc, ChargingProcessState>(
                  listenWhen: (o, n) {
                    final isThisConnector = connector.id == n.processes.last.connector.id;
                    final isStartStatusChanged = o.startProcessStatus != n.startProcessStatus;
                    return isThisConnector && isStartStatusChanged;
                  },
                  listener: (BuildContext context, ChargingProcessState state) async {
                    if (state.startProcessStatus.isFailure) {
                      context.showPopUp(
                        context,
                        PopUpStatus.failure,
                        message: state.startProcessErrorMessage,
                      );
                    } else if (state.startProcessStatus.isSuccess) {
                      onClose();
                      Navigator.popUntil(context, (route) => route.isFirst);
                      context.read<PresentBottomSheetBloc>().add(ShowPresentBottomSheet(isPresented: false));
                      showCupertinoModalBottomSheet(
                        context: context,
                        backgroundColor: AppColors.white,
                        enableDrag: false,
                        isDismissible: false,
                        builder: (ctx) {
                          return ChargingProcessSheet(connector: connector);
                        },
                      );
                    }
                  },
                  buildWhen: (o, n) {
                    return o.startProcessStatus != n.startProcessStatus;
                  },
                  builder: (context, state) {
                    return WButton(
                      height: 32,
                      borderRadius: 10,
                      color: getColor().withOpacity(0.1),
                      rippleColor: AppColors.dodgerBlue.withAlpha(30),
                      isLoading: connector.status == 'Preparing' &&
                          isNearToStation &&
                          state.startProcessStatus.isInProgress &&
                          connector.id == state.processes.last.connector.id,
                      loadingWidget: CupertinoActivityIndicator(
                        color: context.theme.primaryColor,
                        radius: 9,
                      ),
                      onTap: () {
                        if (authState.authenticationStatus.isAuthenticated) {
                          if (connector.status == 'Preparing' && isNearToStation) {
                            context.read<ChargingProcessBloc>().add(
                                  CreateChargingProcessEvent(
                                    connector,
                                    locationName: locationName,
                                  ),
                                );
                          }
                        } else {
                          showLoginDialog(context, onConfirm: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignInPage(),
                              ),
                            );
                          });
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          getIcon(),
                          const SizedBox(width: 4),
                          Text(
                            getText(),
                            style: context.textTheme.labelLarge!.copyWith(
                              color: getColor(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color getColor() {
    final status = ConnectorStatus.fromString(connector.status);
    if (connector.status == 'Preparing' && isNearToStation) {
      return AppColors.dodgerBlue;
    } else if (connector.status == 'Available' && isNearToStation) {
      return AppColors.amaranth;
    } else if (status.isNotWorking) {
      return AppColors.blueBayoux;
    } else {
      return status.color;
    }
  }

  Widget getIcon() {
    final status = ConnectorStatus.fromString(connector.status);
    if (status.isBusy || status.isBooked) return const SizedBox.shrink();
    if (connector.status == 'Preparing' && isNearToStation) {
      return SvgPicture.asset(AppIcons.preparingStatusIcon);
    } else if (connector.status == 'Available' && isNearToStation) {
      return SvgPicture.asset(AppIcons.nearStationStatusIcon);
    } else if (status.isNotWorking) {
      return SvgPicture.asset(AppIcons.notWorkingStatusIcon);
    } else {
      return SvgPicture.asset(status.icon);
    }
  }

  String getText() {
    final status = ConnectorStatus.fromString(connector.status);
    if (connector.status == 'Preparing' && isNearToStation) {
      return LocaleKeys.start_charging.tr();
    } else if (connector.status == 'Available' && isNearToStation) {
      return LocaleKeys.connect_car.tr();
    } else {
      return status.title.tr();
    }
  }
}
