import 'package:equatable/equatable.dart';

class CreateCreditCardEntity extends Equatable {
  final String phoneNumber;
  final String token;

  const CreateCreditCardEntity({required this.phoneNumber, required this.token});

  @override
  List<Object?> get props => [phoneNumber, token];
}