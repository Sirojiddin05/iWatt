part of 'appeal_bloc.dart';

class AppealEvent extends Equatable {
  const AppealEvent();

  @override
  List<Object?> get props => [];
}

class GetAppealsEvent extends AppealEvent {}

class GetMoreAppeals extends AppealEvent {}

class AddAppeal extends AppealEvent {
  final String title;

  const AddAppeal({required this.title});
}

class SendAppealEvent extends AppealEvent {
  final int location;
  final String text;

  const SendAppealEvent({
    required this.location,
    this.text = '',
  });
}
