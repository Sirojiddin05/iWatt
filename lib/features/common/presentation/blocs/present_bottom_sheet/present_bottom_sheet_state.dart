part of 'present_bottom_sheet_bloc.dart';

class PresentBottomSheetState extends Equatable {
  const PresentBottomSheetState({
    this.isPresented = false,
  });

  final bool isPresented;

  PresentBottomSheetState copyWith({
    bool? isPresented,
  }) {
    return PresentBottomSheetState(
      isPresented: isPresented ?? this.isPresented,
    );
  }

  @override
  List<Object> get props => [isPresented];
}
