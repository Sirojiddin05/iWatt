part of 'location_statuses_bloc.dart';

class LocationStatuesState extends Equatable {
  final List<LocationFilterKeyEntity> filterKeys;
  final FormzSubmissionStatus filterKeysStatus;
  final String filterKeysError;

  const LocationStatuesState({
    this.filterKeys = const [],
    this.filterKeysStatus = FormzSubmissionStatus.initial,
    this.filterKeysError = '',
  });

  LocationStatuesState copyWith({
    List<LocationFilterKeyEntity>? filterKeys,
    FormzSubmissionStatus? filterKeysStatus,
    String? filterKeysError,
  }) =>
      LocationStatuesState(
          filterKeys: filterKeys ?? this.filterKeys,
          filterKeysStatus: filterKeysStatus ?? this.filterKeysStatus,
          filterKeysError: filterKeysError ?? this.filterKeysError);

  @override
  List<Object?> get props => [filterKeys, filterKeysStatus, filterKeysError];
}
