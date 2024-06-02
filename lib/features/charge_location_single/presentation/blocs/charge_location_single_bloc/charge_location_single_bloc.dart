import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/charge_location_single_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/usecases/get_charge_location_single_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/connector_status_message.dart';
import 'package:i_watt_app/features/common/domain/usecases/connector_status_stream_usecase.dart';

part 'charge_location_single_event.dart';
part 'charge_location_single_state.dart';

class ChargeLocationSingleBloc extends Bloc<ChargeLocationSingleEvent, ChargeLocationSingleState> {
  final GetChargeLocationSingleUseCase getChargeLocationSingleUseCase;
  final ConnectorStatusStreamUseCase connectorStatusStreamUseCase;
  late final StreamSubscription<ConnectorStatusMessageEntity> connectorStausStreamSubscription;
  final double latitude;
  final double longitude;
  ChargeLocationSingleBloc({
    required this.getChargeLocationSingleUseCase,
    required this.connectorStatusStreamUseCase,
    required String latitude,
    required String longitude,
  })  : latitude = double.tryParse(latitude) ?? 0,
        longitude = double.tryParse(longitude) ?? 0,
        super(const ChargeLocationSingleState()) {
    connectorStausStreamSubscription = connectorStatusStreamUseCase.call(NoParams()).listen((event) {
      add(ChangeConnectorStatus(connectorId: event.connectorId, status: event.status));
    });
    on<GetLocationSingle>((event, emit) async {
      emit(state.copyWith(getSingleStatus: FormzSubmissionStatus.inProgress));
      final result = await getChargeLocationSingleUseCase.call(event.id);
      if (result.isRight) {
        final allConnectors = <ConnectorEntity>[];
        for (final charger in result.right.chargers) {
          allConnectors.addAll(charger.connectors);
        }
        emit(state.copyWith(
          getSingleStatus: FormzSubmissionStatus.success,
          location: result.right,
          allConnectors: allConnectors,
        ));
      } else {
        emit(state.copyWith(
          getSingleStatus: FormzSubmissionStatus.failure,
          errorMessage: result.left.errorMessage,
        ));
      }
    });
    on<ChangeSelectedStationIndexByConnectorId>((event, emit) {
      for (int i = 0; i < state.location.chargers.length; i++) {
        final charger = state.location.chargers[i];
        for (int j = 0; j < charger.connectors.length; j++) {
          final connector = charger.connectors[j];
          if (connector.id == event.connectorId) {
            emit(state.copyWith(selectedStationIndex: i));
            break;
          }
        }
      }
    });
    on<SetIsNearToStation>((event, emit) {
      emit(state.copyWith(isNearToStation: event.isNearToStation));
    });
    on<ChangeConnectorStatus>((event, emit) {
      final allConnectors = [...state.allConnectors];
      for (int i = 0; i < allConnectors.length; i++) {
        final connector = allConnectors[i];
        if (connector.id == event.connectorId) {
          allConnectors[i] = connector.copyWith(status: event.status);
          break;
        }
      }
      final allChargers = [...state.location.chargers];
      for (int i = 0; i < allChargers.length; i++) {
        final charger = allChargers[i];
        for (int j = 0; j < charger.connectors.length; j++) {
          final connector = charger.connectors[j];
          if (connector.id == event.connectorId) {
            charger.connectors[j] = connector.copyWith(status: event.status);
            break;
          }
        }
      }
      emit(
        state.copyWith(
          allConnectors: [...allConnectors],
          location: state.location.copyWith(chargers: allChargers),
        ),
      );
    });
  }

  void initializeLocationStream() async {
    if (latitude != 0 && longitude != 0) {
      final locationPermission = await MyFunctions.getWhetherPermissionGranted();
      if (locationPermission.isPermissionGranted) {
        Geolocator.getPositionStream().listen((position) {
          final distance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            latitude,
            longitude,
          );
          if (distance <= 15) {
            add(const SetIsNearToStation(true));
          } else {
            add(const SetIsNearToStation(false));
          }
        });
      }
    }
  }
}
