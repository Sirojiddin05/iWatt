import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';

class ChargingProcessEntity extends Equatable {
  const ChargingProcessEntity({
    this.connector = const ConnectorEntity(),
    this.startCommandId = -1,
    this.stopCommandId = -1,
    this.transactionId = -1,
    this.money = '',
    this.batteryPercent = -1,
    this.consumedKwh = '',
    this.status = '',
    this.currentKwh = '',
    this.estimatedTime = '',
    this.locationName = '',
    this.parkingStartTime = '',
    this.freeParkingMinutes = -1,
    this.parkingPrice = '',
    this.isPayedParkingStarted = false,
    this.payedParkingLasts = -1,
    this.payedParkingWillStartAfter = -1,
    this.payedParkingPrice = -1,
    this.payedParkingTimer,
    this.freeParkingTimer,
  });

  final int transactionId;
  final int startCommandId;
  final int stopCommandId;
  final String locationName;
  final ConnectorEntity connector;
  final String money;
  final int batteryPercent;
  final String consumedKwh;
  final String currentKwh;
  final String status;
  final String estimatedTime;
  final String parkingStartTime;
  final int freeParkingMinutes;
  final String parkingPrice;
  final bool isPayedParkingStarted;
  final int payedParkingLasts;
  final int payedParkingWillStartAfter;
  final int payedParkingPrice;
  final Timer? payedParkingTimer;
  final Timer? freeParkingTimer;

  ChargingProcessEntity copyWith({
    int? transactionId,
    int? startCommandId,
    int? stopCommandId,
    String? locationName,
    ConnectorEntity? connector,
    String? money,
    int? batteryPercent,
    String? consumedKwh,
    String? currentKwh,
    String? status,
    String? estimatedTime,
    String? parkingStartTime,
    int? freeParkingMinutes,
    String? parkingPrice,
    bool? isPayedParkingStarted,
    int? payedParkingLasts,
    int? payedParkingWillStartAfter,
    int? payedParkingPrice,
    Timer? payedParkingTimer,
    Timer? freeParkingTimer,
  }) {
    return ChargingProcessEntity(
      transactionId: transactionId ?? this.transactionId,
      startCommandId: startCommandId ?? this.startCommandId,
      stopCommandId: stopCommandId ?? this.stopCommandId,
      locationName: locationName ?? this.locationName,
      connector: connector ?? this.connector,
      money: money ?? this.money,
      batteryPercent: batteryPercent ?? this.batteryPercent,
      consumedKwh: consumedKwh ?? this.consumedKwh,
      status: status ?? this.status,
      currentKwh: currentKwh ?? this.currentKwh,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      parkingStartTime: parkingStartTime ?? this.parkingStartTime,
      freeParkingMinutes: freeParkingMinutes ?? this.freeParkingMinutes,
      parkingPrice: parkingPrice ?? this.parkingPrice,
      isPayedParkingStarted: isPayedParkingStarted ?? this.isPayedParkingStarted,
      payedParkingLasts: payedParkingLasts ?? this.payedParkingLasts,
      payedParkingWillStartAfter: payedParkingWillStartAfter ?? this.payedParkingWillStartAfter,
      payedParkingPrice: payedParkingPrice ?? this.payedParkingPrice,
      payedParkingTimer: payedParkingTimer ?? this.payedParkingTimer,
      freeParkingTimer: freeParkingTimer ?? this.freeParkingTimer,
    );
  }

  @override
  List<Object?> get props => [
        transactionId,
        startCommandId,
        stopCommandId,
        locationName,
        connector,
        money,
        batteryPercent,
        consumedKwh,
        currentKwh,
        status,
        estimatedTime,
        parkingStartTime,
        freeParkingMinutes,
        parkingPrice,
        isPayedParkingStarted,
        payedParkingLasts,
        payedParkingWillStartAfter,
        payedParkingPrice,
        payedParkingTimer,
        freeParkingTimer,
      ];
}
