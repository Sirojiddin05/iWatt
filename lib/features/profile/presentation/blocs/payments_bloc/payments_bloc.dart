import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/enums/payment_type_enum.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  // final GetTransactionLinkUseCase getTransactionLinkUseCase = GetTransactionLinkUseCase(serviceLocator<PaymentsRepositoryImpl>());
  // final GetPaymentSystemsUseCase getPaymentSystemsUseCase = GetPaymentSystemsUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());
  // final GetTransactionStateUseCase getTransactionStateUseCase =
  //     GetTransactionStateUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());
  // final PayWithCardUseCase payWithCardUseCase = PayWithCardUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());

  PaymentBloc() : super(const PaymentState()) {
    on<PayWithCard>((event, emit) async {
      // emit(state.copyWith(payWithCardStatus: FormzSubmissionStatus.inProgress));
      //
      // final result = await payWithCardUseCase.call(PayWithCardParams(cardId: state.selectUserCardId, amount: state.amount));
      // if (result.isRight) {
      //   emit(state.copyWith(payWithCardStatus: FormzSubmissionStatus.success));
      //   event.onSuccess();
      // } else {
      //   String message = "";
      //   if (result.left is ServerFailure) {
      //     message = (result.left as ServerFailure).errorMessage.toString().contains("insufficient_funds")
      //         ? LocaleKeys.there_are_insufficient_funds_on_your_card.tr()
      //         : (result.left as ServerFailure).errorMessage.toString();
      //   } else if (result.left is ParsingFailure) {
      //     message = LocaleKeys.failed_to_pay_please_try_again.tr();
      //   } else if (result.left is DioFailure) {
      //     message = LocaleKeys.failed_to_pay_please_try_again.tr();
      //   } else {
      //     message = LocaleKeys.failed_to_pay_please_try_again.tr();
      //   }
      //   emit(state.copyWith(payWithCardStatus: FormzSubmissionStatus.failure));
      //   event.onError(message);
      // }
    });

    on<GetAvailablePaymentSystemsEvent>((event, emit) async {
      // emit(state.copyWith(getPaymentSystemsStatus: FormzSubmissionStatus.inProgress));
      // final result = await getPaymentSystemsUseCase.call(NoParams());
      // if (result.isRight) {
      //   emit(state.copyWith(getPaymentSystemsStatus: FormzSubmissionStatus.success, paymentSystems: result.right.results));
      // } else {
      //   emit(state.copyWith(getPaymentSystemsStatus: FormzSubmissionStatus.failure));
      // }
    });

    on<GetTransactionStateEvent>((event, emit) async {
      // emit(state.copyWith(getTransactionStateStatus: FormzSubmissionStatus.inProgress));
      // final result =
      //     await getTransactionStateUseCase.call(TransactionStatusParams(amount: state.amount.toString(), transactionId: state.transactionId));
      //
      // if (result.isRight) {
      //   emit(state.copyWith(
      //       getTransactionStateStatus: FormzSubmissionStatus.success,
      //       transactionState: FormzSubmissionStatus.success,
      //       paymentStatusEntity: result.right));
      // } else {
      //   String errorMessage = '';
      //   errorMessage = (result.left as ServerFailure).errorMessage.toString();
      //   if (errorMessage.contains("in progress")) {
      //     emit(state.copyWith(
      //       transactionState: FormzSubmissionStatus.inProgress,
      //       getTransactionStateStatus: FormzSubmissionStatus.success,
      //     ));
      //   } else if (errorMessage.contains("transaction not found") || errorMessage.contains("transaction is rejcted")) {
      //     emit(state.copyWith(
      //       transactionState: FormzSubmissionStatus.failure,
      //       getTransactionStateStatus: FormzSubmissionStatus.success,
      //     ));
      //   }
      // }
    });

    on<GetTransactionLinkEvent>((event, emit) async {
      // emit(state.copyWith(getTransactionLinkStatus: FormzSubmissionStatus.inProgress));
      // final result = await getTransactionLinkUseCase.call(GetTransactionLinkParams(amount: state.amount, type: state.selectedSystemTitle));
      // if (result.isRight) {
      //   emit(state.copyWith(
      //     getTransactionLinkStatus: FormzSubmissionStatus.success,
      //     transactionId: result.right.transactionId,
      //     transactionState: FormzSubmissionStatus.inProgress,
      //     transactionLink: result.right.url,
      //   ));
      //   launchUrlString(result.right.url);
      // } else {
      //   emit(state.copyWith(getTransactionLinkStatus: FormzSubmissionStatus.failure));
      // }
    });

    on<SelectPaymentSystem>((event, emit) async {
      emit(state.copyWith(selectedSystemTitle: event.title));
    });
    on<SavePaymentSumEvent>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });
    on<SavePaymentTypeEvent>((event, emit) {
      emit(state.copyWith(selectedPaymentType: event.paymentType));
    });
    on<SelectUserCardEvent>((event, emit) {
      emit(state.copyWith(selectUserCardId: event.id));
    });
  }
}
