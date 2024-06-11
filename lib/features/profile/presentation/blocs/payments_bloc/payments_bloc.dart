import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/profile/domain/usecases/pay_with_card_params.dart';
import 'package:i_watt_app/features/profile/domain/usecases/pay_with_card_usecase.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PayWithCardUseCase payWithCardUseCase;

  PaymentBloc(this.payWithCardUseCase) : super(const PaymentState()) {
    on<PayWithCard>((event, emit) async {
      emit(state.copyWith(payWithCardStatus: FormzSubmissionStatus.inProgress));
      final result = await payWithCardUseCase.call(
        PayWithCardParams(
          cardId: state.selectUserCardId,
          amount: event.amount ?? state.amount,
        ),
      );
      if (result.isRight) {
        emit(state.copyWith(payWithCardStatus: FormzSubmissionStatus.success));
      } else {
        emit(
          state.copyWith(
            payWithCardStatus: FormzSubmissionStatus.failure,
            payWithCardError: result.left.errorMessage,
          ),
        );
      }
    });
    on<SavePaymentSumEvent>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });
    on<SelectUserCardEvent>((event, emit) {
      emit(state.copyWith(selectUserCardId: event.id));
    });
  }
}
