part of 'present_bottom_sheet_bloc.dart';

@immutable
abstract class PresentBottomSheetEvent {}

class ShowPresentBottomSheet extends PresentBottomSheetEvent {
  final bool isPresented;

  ShowPresentBottomSheet({required this.isPresented});
}
