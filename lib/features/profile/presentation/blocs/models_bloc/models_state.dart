part of 'models_bloc.dart';

class ModelsState extends Equatable {
  final int manufacturerId;
  final FormzSubmissionStatus getModelsStatus;
  final List<IdNameEntity> models;
  final String error;

  const ModelsState({
    this.manufacturerId = -1,
    this.getModelsStatus = FormzSubmissionStatus.initial,
    this.models = const [],
    this.error = '',
  });

  ModelsState copyWith({
    int? manufacturerId,
    FormzSubmissionStatus? getModelsStatus,
    List<IdNameEntity>? models,
    String? error,
  }) {
    return ModelsState(
      getModelsStatus: getModelsStatus ?? this.getModelsStatus,
      models: models ?? this.models,
      manufacturerId: manufacturerId ?? this.manufacturerId,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        getModelsStatus,
        models,
        manufacturerId,
        error,
      ];
}
