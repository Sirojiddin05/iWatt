import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/appeal_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/send_appeal_param_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/usecases/get_appeals_usecase.dart';
import 'package:i_watt_app/features/charge_location_single/domain/usecases/send_appeal_usecase.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

part 'appeal_event.dart';
part 'appeal_state.dart';

class AppealBloc extends Bloc<AppealEvent, AppealState> {
  final SendAppealsUseCase chargerAppealUseCase;
  final GetAppealsUseCase getAppealsUseCase;
  AppealBloc({required this.chargerAppealUseCase, required this.getAppealsUseCase}) : super(const AppealState()) {
    on<GetAppealsEvent>((event, emit) async {
      emit(state.copyWith(getAppealsStatus: FormzSubmissionStatus.inProgress));

      final result = await getAppealsUseCase.call('');
      if (result.isRight) {
        final newList = [
          ...result.right.results,
          const AppealEntity().copyWith(title: LocaleKeys.other_neuter, id: 0),
        ];

        emit(state.copyWith(
          getAppealsStatus: FormzSubmissionStatus.success,
          appeals: newList,
          next: result.right.next,
          fetchMore: result.right.next != null,
        ));
      } else {
        emit(state.copyWith(getAppealsStatus: FormzSubmissionStatus.failure));
      }
    });

    on<SendAppealEvent>((event, emit) async {
      emit(state.copyWith(sendAppealStatus: FormzSubmissionStatus.inProgress));
      final result = await chargerAppealUseCase.call(SendAppealParams(id: event.title, location: event.location, otherAppeal: event.text));
      if (result.isRight) {
        emit(state.copyWith(sendAppealStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(sendAppealStatus: FormzSubmissionStatus.failure, sendErrorMessage: result.left.errorMessage));
      }
    });
  }
}
