part of 'credit_cards_bloc.dart';

class CreditCardsState extends Equatable {
  final FormzSubmissionStatus getCreditCardsStatus;
  final FormzSubmissionStatus confirmCardStatus;
  final FormzSubmissionStatus createCardStatus;
  final FormzSubmissionStatus deleteCardStatus;
  final List<CreditCardEntity> creditCards;
  final CreditCardEntity selectedCreditCard;
  final String creditCardsNext;
  final String otpSentPhone;
  final String errorMessage;
  final int codeAvailableTime;
  final String cardNumber;
  final String cardExpiryDate;
  final String cardToken;

  const CreditCardsState({
    this.getCreditCardsStatus = FormzSubmissionStatus.initial,
    this.confirmCardStatus = FormzSubmissionStatus.initial,
    this.createCardStatus = FormzSubmissionStatus.initial,
    this.deleteCardStatus = FormzSubmissionStatus.initial,
    this.creditCards = const [],
    this.selectedCreditCard = const CreditCardEntity(),
    this.creditCardsNext = '',
    this.otpSentPhone = '',
    this.errorMessage = '',
    this.codeAvailableTime = 0,
    this.cardNumber = '',
    this.cardExpiryDate = '',
    this.cardToken = '',
  });

  CreditCardsState copyWith({
    FormzSubmissionStatus? getCreditCardsStatus,
    FormzSubmissionStatus? confirmCardStatus,
    FormzSubmissionStatus? createCardStatus,
    FormzSubmissionStatus? deleteCardStatus,
    List<CreditCardEntity>? creditCards,
    CreditCardEntity? selectedCreditCard,
    String? creditCardsNext,
    String? otpSentPhone,
    String? errorMessage,
    int? codeAvailableTime,
    String? cardNumber,
    String? cardExpiryDate,
    String? cardToken,
  }) {
    return CreditCardsState(
      getCreditCardsStatus: getCreditCardsStatus ?? this.getCreditCardsStatus,
      confirmCardStatus: confirmCardStatus ?? this.confirmCardStatus,
      createCardStatus: createCardStatus ?? this.createCardStatus,
      deleteCardStatus: deleteCardStatus ?? this.deleteCardStatus,
      creditCards: creditCards ?? this.creditCards,
      selectedCreditCard: selectedCreditCard ?? this.selectedCreditCard,
      creditCardsNext: creditCardsNext ?? this.creditCardsNext,
      otpSentPhone: otpSentPhone ?? this.otpSentPhone,
      errorMessage: errorMessage ?? this.errorMessage,
      codeAvailableTime: codeAvailableTime ?? this.codeAvailableTime,
      cardNumber: cardNumber ?? this.cardNumber,
      cardExpiryDate: cardExpiryDate ?? this.cardExpiryDate,
      cardToken: cardToken ?? this.cardToken,
    );
  }

  @override
  List<Object> get props => [
        getCreditCardsStatus,
        confirmCardStatus,
        createCardStatus,
        deleteCardStatus,
        creditCards,
        selectedCreditCard,
        creditCardsNext,
        otpSentPhone,
        errorMessage,
        codeAvailableTime,
        cardNumber,
        cardExpiryDate,
        cardToken,
      ];
}
