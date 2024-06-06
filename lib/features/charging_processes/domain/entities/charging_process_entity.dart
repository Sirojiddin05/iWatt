import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/meter_value_message.dart';
import 'package:i_watt_app/features/common/domain/entities/parking_data_message.dart';

class ChargingProcessEntity extends Equatable {
  final ConnectorEntity connector;
  final int startCommandId;
  final int stopCommandId;
  final int transactionId;
  final MeterValueMessageEntity meterValue;
  final String status;
  final String locationName;
  final String estimatedTime;
  final ParkingDataMessageEntity parkingData;
  final bool isPayedParkingStarted;
  final int payedParkingLasts;
  final int payedParkingWillStartAfter;
  final int payedParkingPrice;
  final Timer? payedParkingTimer;
  final Timer? freeParkingTimer;

  const ChargingProcessEntity({
    this.connector = const ConnectorEntity(),
    this.startCommandId = -1,
    this.stopCommandId = -1,
    this.transactionId = -1,
    this.meterValue = const MeterValueMessageEntity(),
    this.parkingData = const ParkingDataMessageEntity(),
    this.status = '',
    this.locationName = '',
    this.estimatedTime = '',
    this.payedParkingLasts = 0,
    this.isPayedParkingStarted = false,
    this.payedParkingWillStartAfter = 0,
    this.payedParkingTimer,
    this.freeParkingTimer,
    this.payedParkingPrice = 0,
  });

  ChargingProcessEntity copyWith({
    int? taskId,
    ConnectorEntity? connector,
    int? startCommandId,
    int? stopCommandId,
    int? transactionId,
    MeterValueMessageEntity? meterValue,
    ParkingDataMessageEntity? parkingData,
    String? status,
    String? locationName,
    String? estimatedTime,
    int? payedParkingLasts,
    bool? isPayedParkingStarted,
    int? payedParkingWillStartAfter,
    int? payedParkingPrice,
    Timer? payedParkingTimer,
    Timer? freeParkingTimer,
  }) {
    return ChargingProcessEntity(
      connector: connector ?? this.connector,
      startCommandId: startCommandId ?? this.startCommandId,
      stopCommandId: stopCommandId ?? this.stopCommandId,
      transactionId: transactionId ?? this.transactionId,
      meterValue: meterValue ?? this.meterValue,
      status: status ?? this.status,
      locationName: locationName ?? this.locationName,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      parkingData: parkingData ?? this.parkingData,
      payedParkingLasts: payedParkingLasts ?? this.payedParkingLasts,
      isPayedParkingStarted: isPayedParkingStarted ?? this.isPayedParkingStarted,
      payedParkingWillStartAfter: payedParkingWillStartAfter ?? this.payedParkingWillStartAfter,
      payedParkingTimer: payedParkingTimer ?? this.payedParkingTimer,
      freeParkingTimer: freeParkingTimer ?? this.freeParkingTimer,
      payedParkingPrice: payedParkingPrice ?? this.payedParkingPrice,
    );
  }

  @override
  List<Object?> get props => [
        connector,
        startCommandId,
        stopCommandId,
        transactionId,
        meterValue,
        status,
        locationName,
        estimatedTime,
        parkingData,
        isPayedParkingStarted,
        payedParkingLasts,
        payedParkingWillStartAfter,
        payedParkingPrice,
        payedParkingTimer,
        freeParkingTimer,
      ];
}
