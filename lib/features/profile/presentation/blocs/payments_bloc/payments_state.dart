part of 'payments_bloc.dart';

class PaymentState extends Equatable {
  final FormzSubmissionStatus payWithCardStatus;
  final FormzSubmissionStatus getPaymentSystemsStatus;
  final FormzSubmissionStatus getTransactionLinkStatus;
  final FormzSubmissionStatus getTransactionStateStatus;
  final FormzSubmissionStatus transactionState;
  // final List<PaymentTypeStatusEntity> paymentSystems;
  final int selectUserCardId;
  final String selectedSystemTitle;
  final PaymentType selectedPaymentType;
  final String paidAt;
  final int transactionId;
  final String transactionLink;
  final int amount;
  // final PaymentStatusEntity paymentStatusEntity;

  const PaymentState({
    this.getPaymentSystemsStatus = FormzSubmissionStatus.initial,
    this.getTransactionLinkStatus = FormzSubmissionStatus.initial,
    this.payWithCardStatus = FormzSubmissionStatus.initial,
    this.getTransactionStateStatus = FormzSubmissionStatus.initial,
    this.transactionState = FormzSubmissionStatus.initial,
    this.selectUserCardId = -1,
    // this.paymentStatusEntity = const PaymentStatusEntity(),
    this.selectedSystemTitle = '',
    this.transactionId = -1,
    this.transactionLink = '',
    this.paidAt = '',
    // this.paymentSystems = const [],
    this.amount = -1,
    this.selectedPaymentType = PaymentType.viaPaymentSystem,
  });

  PaymentState copyWith({
    FormzSubmissionStatus? getPaymentSystemsStatus,
    FormzSubmissionStatus? getTransactionLinkStatus,
    FormzSubmissionStatus? payWithCardStatus,
    FormzSubmissionStatus? getTransactionStateStatus,
    FormzSubmissionStatus? transactionState,
    // List<PaymentTypeStatusEntity>? paymentSystems,
    String? selectedSystemTitle,
    int? selectUserCardId,
    PaymentType? selectedPaymentType,
    int? transactionId,
    int? amount,
    int? selectedUserCardId,
    String? paidAt,
    String? transactionLink,
    // PaylovWithCardEntity? paylovWithCardEntity,
    // PaymentStatusEntity? paymentStatusEntity,
  }) {
    return PaymentState(
      payWithCardStatus: payWithCardStatus ?? this.payWithCardStatus,
      getPaymentSystemsStatus: getPaymentSystemsStatus ?? this.getPaymentSystemsStatus,
      getTransactionLinkStatus: getTransactionLinkStatus ?? this.getTransactionLinkStatus,
      getTransactionStateStatus: getTransactionStateStatus ?? this.getTransactionStateStatus,
      transactionState: transactionState ?? this.transactionState,
      // paymentSystems: paymentSystems ?? this.paymentSystems,
      paidAt: paidAt ?? this.paidAt,
      amount: amount ?? this.amount,
      transactionId: transactionId ?? this.transactionId,
      selectedSystemTitle: selectedSystemTitle ?? this.selectedSystemTitle,
      selectedPaymentType: selectedPaymentType ?? this.selectedPaymentType,
      selectUserCardId: selectUserCardId ?? this.selectUserCardId,
      // paymentStatusEntity: paymentStatusEntity ?? this.paymentStatusEntity,
      transactionLink: transactionLink ?? this.transactionLink,
    );
  }

  @override
  List<Object?> get props => [
        getPaymentSystemsStatus,
        getTransactionStateStatus,
        payWithCardStatus,
        selectUserCardId,
        // paymentSystems,
        selectedSystemTitle,
        paidAt,
        transactionId,
        transactionLink,
        amount,
        transactionState,
        getTransactionLinkStatus,
        // paymentStatusEntity,
        selectedPaymentType
      ];
}
