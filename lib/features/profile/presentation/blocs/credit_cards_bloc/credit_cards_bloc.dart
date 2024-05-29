import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:i_watt_app/service_locator.dart';

part 'credit_cards_event.dart';
part 'credit_cards_state.dart';

class CreditCardsBloc extends Bloc<CreditCardsEvent, CreditCardsState> {
  final CreateCreditCardUseCase createCreditCardUseCase =
      CreateCreditCardUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());
  final ConfirmCreditCardUseCase confirmCreditCardUseCase =
      ConfirmCreditCardUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());
  final DeleteCreditCardUseCase deleteCardUseCase =
      DeleteCreditCardUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());
  final GetCreditCardsUseCase getCreditCardsUseCase =
      GetCreditCardsUseCase(paymentsRepository: serviceLocator<PaymentsRepositoryImpl>());

  CreditCardsBloc() : super(const CreditCardsState()) {
    on<DeleteCreditCardEvent>((event, emit) async {
      emit(state.copyWith(deleteCardStatus: FormzSubmissionStatus.inProgress));

      final result = await deleteCardUseCase.call(event.id);
      if (result.isRight) {
        emit(state.copyWith(
          deleteCardStatus: FormzSubmissionStatus.success,
        ));
        event.onSuccess();
      } else {
        emit(state.copyWith(deleteCardStatus: FormzSubmissionStatus.failure));
        event.onError((result.left as ServerFailure).errorMessage.toString());
      }
    });
    on<CreateCreditCard>((event, emit) async {
      emit(state.copyWith(createCardStatus: FormzSubmissionStatus.inProgress));

      final result = await createCreditCardUseCase
          .call(CreateCardParams(cardNumber: event.cardNumber, expireDate: event.expireDate));
      if (result.isRight) {
        emit(state.copyWith(otpSentPhone: result.right, createCardStatus: FormzSubmissionStatus.success));
        event.onSuccess(60);
      } else {
        String error = '';
        if (result.left is ServerFailure) {
          if (result.left.errorMessage.toString().contains("card_not_found")) {
            error = LocaleKeys.card_not_found.tr();
          }
          if (result.left.errorMessage.toString().contains("card_expired")) {
            error = LocaleKeys.card_expired.tr();
          } else if (result.left.errorMessage != null) {
            error = error;
          }
        } else if (result.left is ParsingFailure) {
          error = LocaleKeys.there_was_a_problem_with_the_server_adding_the_card.tr();
        } else if (result.left is DioFailure) {
          error = LocaleKeys.there_was_a_problem_with_the_server_adding_the_card.tr();
        } else {
          error = LocaleKeys.there_was_a_problem_with_the_server_adding_the_card.tr();
        }
        emit(state.copyWith(createCardStatus: FormzSubmissionStatus.failure));
        event.onError(error);
      }
    });
    on<ConfirmCreditCardEvent>((event, emit) async {
      emit(state.copyWith(confirmCardStatus: FormzSubmissionStatus.inProgress));
      final result = await confirmCreditCardUseCase.call((cardNumber: event.cardNumber, otp: event.otp));
      if (result.isRight) {
        emit(state.copyWith(confirmCardStatus: FormzSubmissionStatus.success));
        event.onSuccess();
      } else {
        emit(state.copyWith(confirmCardStatus: FormzSubmissionStatus.failure));
        if (result.left.errorMessage.toString().contains('otp_is_not_correct')) {
          event.onError(LocaleKeys.verification_not_right.tr());
        } else {
          event.onError(result.left.errorMessage.toString());
        }
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
  }
}
