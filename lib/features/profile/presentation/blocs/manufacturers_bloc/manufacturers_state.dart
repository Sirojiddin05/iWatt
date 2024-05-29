part of 'manufacturers_bloc.dart';

class ManufacturersState extends Equatable {
  const ManufacturersState({
    this.getManufacturers = FormzSubmissionStatus.initial,
    this.manufacturers = const [],
    this.next = '',
    this.fetchMore = false,
    this.searchQuery = '',
    this.error = '',
  });

  final FormzSubmissionStatus getManufacturers;
  final List<IdNameEntity> manufacturers;
  final String next;
  final bool fetchMore;
  final String searchQuery;
  final String error;

  ManufacturersState copyWith({
    FormzSubmissionStatus? getManufacturers,
    List<IdNameEntity>? manufacturers,
    String? next,
    bool? fetchMore,
    String? searchQuery,
    String? error,
  }) {
    return ManufacturersState(
      getManufacturers: getManufacturers ?? this.getManufacturers,
      manufacturers: manufacturers ?? this.manufacturers,
      next: next ?? this.next,
      fetchMore: fetchMore ?? this.fetchMore,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        getManufacturers,
        manufacturers,
        next,
        fetchMore,
        searchQuery,
        error,
      ];
}
