import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';
import 'package:i_watt_app/features/common/domain/usecases/transaction_cheque_stream_usecase.dart';
import 'package:meta/meta.dart';

part 'transaction_cheque_event.dart';
part 'transaction_cheque_state.dart';

class TransactionChequeBloc extends Bloc<TransactionChequeEvent, TransactionChequeState> {
  final TransactionChequeStreamUseCase _transactionChequeStreamUseCase;
  TransactionChequeBloc(this._transactionChequeStreamUseCase) : super(const TransactionChequeState()) {
    on<TransactionChequeEvent>((event, emit) {});
  }
}
