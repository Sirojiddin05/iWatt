import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/charge_location_single_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/usecases/get_charge_location_single_usecase.dart';

part 'charge_location_single_event.dart';
part 'charge_location_single_state.dart';

class ChargeLocationSingleBloc extends Bloc<ChargeLocationSingleEvent, ChargeLocationSingleState> {
  final GetChargeLocationSingleUseCase _getChargeLocationSingleUseCase;
  ChargeLocationSingleBloc(
    this._getChargeLocationSingleUseCase,
  ) : super(const ChargeLocationSingleState()) {
    on<GetLocationSingle>((event, emit) async {
      emit(state.copyWith(getSingleStatus: FormzSubmissionStatus.inProgress));
      final result = await _getChargeLocationSingleUseCase.call(event.id);

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
  }
}
