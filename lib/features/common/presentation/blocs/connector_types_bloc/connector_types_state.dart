part of 'connector_types_bloc.dart';

class ConnectorTypesState extends Equatable {
  const ConnectorTypesState({
    this.getConnectorTypesStatus = FormzSubmissionStatus.initial,
    this.acConnectionTypes = const [],
    this.dcConnectionTypes = const [],
  });

  final FormzSubmissionStatus getConnectorTypesStatus;
  final List<IdNameEntity> acConnectionTypes;
  final List<IdNameEntity> dcConnectionTypes;

  ConnectorTypesState copyWith({
    FormzSubmissionStatus? getConnectorTypesStatus,
    List<IdNameEntity>? acConnectionTypes,
    List<IdNameEntity>? dcConnectionTypes,
  }) {
    return ConnectorTypesState(
      getConnectorTypesStatus: getConnectorTypesStatus ?? this.getConnectorTypesStatus,
      acConnectionTypes: acConnectionTypes ?? this.acConnectionTypes,
      dcConnectionTypes: dcConnectionTypes ?? this.dcConnectionTypes,
    );
  }

  @override
  List<Object> get props => [
        getConnectorTypesStatus,
        acConnectionTypes,
        dcConnectionTypes,
      ];
}
