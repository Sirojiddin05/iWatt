import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/check_data_column.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/cheque_widget_wrapper.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ChequeWidget extends StatelessWidget {
  final TransactionMessageEntity cheque;

  const ChequeWidget({super.key, required this.cheque});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ChequeWidgetWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckDataColumn(
                title: "${LocaleKeys.charging_id.tr()}:",
                data: cheque.transactionId.toString(),
                padding: const EdgeInsets.only(bottom: 10),
              ),
              Divider(color: context.theme.dividerColor, height: 1, thickness: 1),
              CheckDataColumn(
                title: "${LocaleKeys.charging_start_time.tr()}:",
                data: MyFunctions.getEventTime(cheque.chargingHasStartedAt),
              ),
              Divider(color: context.theme.dividerColor, height: 1, thickness: 1),
              CheckDataColumn(
                title: "${LocaleKeys.charging_end_time.tr()}:",
                data: MyFunctions.getEventTime(cheque.chargingHasEndedAt),
              ),
              Divider(color: context.theme.dividerColor, height: 1, thickness: 1),
              CheckDataColumn(
                title: "${LocaleKeys.station_cpital.tr()}:",
                data: '${cheque.vendorName} "${cheque.locationName}"',
              ),
              Divider(color: context.theme.dividerColor, height: 1, thickness: 1),
              CheckDataColumn(
                title: "${LocaleKeys.consumed.tr()}:",
                data: "${cheque.consumedKwh} ${LocaleKeys.kW.tr()}",
              ),
              Divider(color: context.theme.dividerColor, height: 1, thickness: 1),
              CheckDataColumn(
                title: "${LocaleKeys.paid_parking.tr()}:",
                data: parkingTime,
                padding: const EdgeInsets.only(top: 10),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ChequeWidgetWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckDataColumn(
                title: "${LocaleKeys.parking_price.tr()}:",
                data: MyFunctions.getPrice(cheque.parkingPrice),
                padding: const EdgeInsets.only(bottom: 10),
              ),
              Divider(color: context.theme.dividerColor, height: 1, thickness: 1),
              CheckDataColumn(
                title: "${LocaleKeys.total_charging_price.tr()}:",
                data: MyFunctions.getPrice(cheque.chargingPrice),
                padding: const EdgeInsets.only(top: 10),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ChequeWidgetWrapper(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${LocaleKeys.payed.tr()}:',
                  style: context.textTheme.headlineSmall,
                ),
              ),
              Text(
                MyFunctions.getPrice(cheque.totalPrice),
                style: context.textTheme.displayMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String get parkingTime {
    if (cheque.parkingStartTime.isEmpty || cheque.parkingEndTime.isEmpty) {
      return '-';
    }
    StringBuffer sb = StringBuffer();
    final time = MyFunctions.getDifferenceBetweenTwoDates(cheque.parkingStartTime, cheque.parkingEndTime);
    final days = time[0];
    final hours = time[1];
    final minutes = time[2];
    final seconds = time[3];
    if (days == 0 && hours == 0 && minutes == 0 && seconds == 0) {
      return '-';
    }
    if (days != 0) {
      sb.write("$days ${MyFunctions.getDaysDueToQuantity(days).tr()} ");
    }
    if (hours != 0) {
      sb.write("$hours ${MyFunctions.getHoursDueToQuantity(hours).tr()} ");
    }
    if (minutes != 0) {
      sb.write("$minutes ${MyFunctions.getMinutesDueToQuantity(minutes).tr()} ");
    }
    if (seconds != 0) {
      sb.write("$seconds ${MyFunctions.getSecondsDueToQuantity(seconds).tr()} ");
    }
    return sb.toString();
  }
}
