part of 'power_types_bloc.dart';

class PowerTypesState extends Equatable {
  const PowerTypesState({
    this.getPowerTypesStatus = FormzSubmissionStatus.initial,
    this.powerTypes = const [],
  });

  final FormzSubmissionStatus getPowerTypesStatus;
  final List<IdNameEntity> powerTypes;

  PowerTypesState copyWith({
    FormzSubmissionStatus? getPowerTypesStatus,
    List<IdNameEntity>? powerTypes,
  }) {
    return PowerTypesState(
      getPowerTypesStatus: getPowerTypesStatus ?? this.getPowerTypesStatus,
      powerTypes: powerTypes ?? this.powerTypes,
    );
  }

  @override
  List<Object> get props => [getPowerTypesStatus, powerTypes];
}
