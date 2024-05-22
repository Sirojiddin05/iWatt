import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_connector_types_usecase.dart';

part 'connector_types_event.dart';
part 'connector_types_state.dart';

class ConnectorTypesBloc extends Bloc<ConnectorTypesEvent, ConnectorTypesState> {
  final GetConnectorTypesUseCase getConnectorTypesUseCase;
  ConnectorTypesBloc(this.getConnectorTypesUseCase) : super(ConnectorTypesState()) {
    on<GetConnectorTypesEvent>((event, emit) async {
      emit(state.copyWith(getConnectorTypesStatus: FormzSubmissionStatus.inProgress));
      final result = await getConnectorTypesUseCase.call(NoParams());
      if (result.isRight) {
        final list = result.right.results;
        final ac = list.where((e) => e.type == 'AC' || e.type == 'ac').toList();
        final dc = list.where((e) => e.type == 'DC' || e.type == 'dc').toList();
        emit(state.copyWith(
          getConnectorTypesStatus: FormzSubmissionStatus.success,
          acConnectionTypes: ac,
          dcConnectionTypes: dc,
        ));
      } else {
        emit(state.copyWith(getConnectorTypesStatus: FormzSubmissionStatus.failure));
      }
    });
  }
}
