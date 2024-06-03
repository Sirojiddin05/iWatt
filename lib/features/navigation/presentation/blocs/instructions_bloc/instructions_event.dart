part of 'instructions_bloc.dart';

@immutable
sealed class InstructionsEvent {}

class GetInstructionsEvent extends InstructionsEvent {
  final String type;

  GetInstructionsEvent(this.type);
}
