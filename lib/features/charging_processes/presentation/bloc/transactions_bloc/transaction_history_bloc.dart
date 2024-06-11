import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/transaction_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/get_single_transaction_usecase.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/get_transaction_history_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  late final GetTransactionHistoryUseCase getTransactionHistoryUseCase;
  late final GetSingleTransactionUseCase getSingleTransactionUseCase;

  TransactionHistoryBloc(this.getTransactionHistoryUseCase) : super(const TransactionHistoryState()) {
    on<GetTransactionHistoryEvent>((event, emit) async {
      emit(state.copyWith(getTransactionHistoryStatus: FormzSubmissionStatus.inProgress));
      final result = await getTransactionHistoryUseCase.call('');
      if (result.isRight) {
        emit(
          state.copyWith(
            getTransactionHistoryStatus: FormzSubmissionStatus.success,
            transactionHistory: result.right.results,
            fetchMore: result.right.next != null,
            next: result.right.next ?? '',
          ),
        );
      }
    });
    on<GetMoreTransactionHistory>((event, emit) async {
      final result = await getTransactionHistoryUseCase.call(state.next);
      if (result.isRight) {
        emit(
          state.copyWith(
            getTransactionHistoryStatus: FormzSubmissionStatus.success,
            transactionHistory: [...state.transactionHistory, ...result.right.results],
            fetchMore: result.right.next != null,
            next: result.right.next ?? '',
          ),
        );
      }
    });
  }

  TransactionHistoryBloc.single(this.getSingleTransactionUseCase) : super(const TransactionHistoryState()) {
    on<GetSingleTransactionEvent>((event, emit) async {
      emit(state.copyWith(getSingleTransactionHistoryStatus: FormzSubmissionStatus.inProgress));
      try {
        final result = await getSingleTransactionUseCase.call(event.transactionId);

        if (result.isRight) {
          print('getSingleTransactionHistoryStatus: success');
          emit(state.copyWith(
            singleTransactionHistory: result.right,
            getSingleTransactionHistoryStatus: FormzSubmissionStatus.success,
          ));
        } else {
          emit(state.copyWith(
            getSingleTransactionHistoryStatus: FormzSubmissionStatus.failure,
          ));
        }
      } catch (e) {
        debugPrint('Errorrrrrrrr: $e');
      }
    });
  }
}
