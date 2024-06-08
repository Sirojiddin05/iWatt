import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/payments_repository_impl.dart';
import 'package:i_watt_app/features/profile/domain/entities/create_card_params.dart';
import 'package:i_watt_app/features/profile/domain/entities/credit_card_entity.dart';
import 'package:i_watt_app/features/profile/domain/usecases/confirm_credit_card_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/create_credit_card_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/delete_credit_card_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/get_credit_cards_usecase.dart';
import 'package:i_watt_app/service_locator.dart';

part 'credit_cards_event.dart';
part 'credit_cards_state.dart';

class CreditCardsBloc extends Bloc<CreditCardsEvent, CreditCardsState> {
  final CreateCreditCardUseCase createCreditCardUseCase = CreateCreditCardUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());
  final ConfirmCreditCardUseCase confirmCreditCardUseCase = ConfirmCreditCardUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());
  final DeleteCreditCardUseCase deleteCardUseCase = DeleteCreditCardUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());
  final GetCreditCardsUseCase getCreditCardsUseCase = GetCreditCardsUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());

  Timer _otpTimer = Timer(Duration.zero, () {});

  CreditCardsBloc() : super(const CreditCardsState()) {
    on<ResendCode>(_onResendCode);
    on<DeleteCreditCardEvent>((event, emit) async {
      emit(state.copyWith(deleteCardStatus: FormzSubmissionStatus.inProgress));
      final result = await deleteCardUseCase.call(event.id);
      if (result.isRight) {
        final creditCards = state.creditCards.where((element) => element.id != event.id).toList();
        emit(
          state.copyWith(
            deleteCardStatus: FormzSubmissionStatus.success,
            creditCards: [...creditCards],
          ),
        );
      } else {
        emit(state.copyWith(deleteCardStatus: FormzSubmissionStatus.failure));
        event.onError((result.left as ServerFailure).errorMessage.toString());
      }
    });
    on<CreateCreditCard>((event, emit) async {
      emit(state.copyWith(createCardStatus: FormzSubmissionStatus.inProgress, cardNumber: event.cardNumber, cardExpiryDate: event.expireDate));
      final result = await createCreditCardUseCase.call(CreateCardParams(cardNumber: event.cardNumber, expireDate: event.expireDate));
      if (result.isRight) {
        emit(
          state.copyWith(
            otpSentPhone: result.right.phoneNumber,
            cardToken: result.right.token,
            createCardStatus: FormzSubmissionStatus.success,
            codeAvailableTime: 60,
          ),
        );
        event.onSuccess();
        _setTimer();
      } else {
        emit(state.copyWith(
          createCardStatus: FormzSubmissionStatus.failure,
          errorMessage: result.left.errorMessage,
        ));
      }
    });
    on<ConfirmCreditCardEvent>((event, emit) async {
      emit(state.copyWith(confirmCardStatus: FormzSubmissionStatus.inProgress));
      final result = await confirmCreditCardUseCase.call((cardToken: state.cardToken, otp: event.otp));
      if (result.isRight) {
        event.onSuccess();
        emit(state.copyWith(confirmCardStatus: FormzSubmissionStatus.success));
      } else {
        event.onError(result.left.errorMessage);
        emit(state.copyWith(confirmCardStatus: FormzSubmissionStatus.failure, errorMessage: result.left.errorMessage));
      }
    });
    on<GetCreditCards>((event, emit) async {
      emit(state.copyWith(getCreditCardsStatus: FormzSubmissionStatus.inProgress));
      final result = await getCreditCardsUseCase.call(null);
      if (result.isRight) {
        emit(state.copyWith(
          creditCards: [...result.right.results],
          creditCardsNext: result.right.next,
          getCreditCardsStatus: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(getCreditCardsStatus: FormzSubmissionStatus.failure));
      }
    });
    on<GetMoreCreditCards>((event, emit) async {
      final result = await getCreditCardsUseCase.call(state.creditCardsNext);
      if (result.isRight) {
        emit(state.copyWith(
          creditCards: [...state.creditCards, ...result.right.results],
          creditCardsNext: result.right.next,
        ));
      }
    });
    on<CodeAvailableTimeDecreased>((event, emit) {
      if (state.codeAvailableTime > 0) {
        emit(state.copyWith(codeAvailableTime: state.codeAvailableTime - 1));
      }
    });
  }

  void _setTimer() {
    if (_otpTimer.isActive) {
      _otpTimer.cancel();
    }
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (state.codeAvailableTime == 0) {
        timer.cancel();
      }
      add(const CodeAvailableTimeDecreased());
    });
  }

  void _onResendCode(ResendCode event, Emitter<CreditCardsState> emit) async {
    final result = await createCreditCardUseCase(CreateCardParams(
      cardNumber: state.cardNumber,
      expireDate: state.cardExpiryDate,
    ));
    if (result.isRight) {
      emit(state.copyWith(
        otpSentPhone: result.right.phoneNumber,
        cardToken: result.right.token,
        codeAvailableTime: 60,
      ));
      _setTimer();
    }
  }
}
