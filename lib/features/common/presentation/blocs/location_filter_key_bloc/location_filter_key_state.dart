part of 'location_filter_key_bloc.dart';

class LocationFilterKeyState extends Equatable {
  final List<LocationFilterKeyEntity> filterKeys;
  final FormzSubmissionStatus filterKeysStatus;
  final String filterKeysError;

  const LocationFilterKeyState({
    this.filterKeys = const [],
    this.filterKeysStatus = FormzSubmissionStatus.initial,
    this.filterKeysError = '',
  });

  LocationFilterKeyState copyWith({
    List<LocationFilterKeyEntity>? filterKeys,
    FormzSubmissionStatus? filterKeysStatus,
    String? filterKeysError,
  }) =>
      LocationFilterKeyState(
          filterKeys: filterKeys ?? this.filterKeys,
          filterKeysStatus: filterKeysStatus ?? this.filterKeysStatus,
          filterKeysError: filterKeysError ?? this.filterKeysError);

  @override
  List<Object?> get props => [filterKeys, filterKeysStatus, filterKeysError];
}
