part of 'vendors_bloc.dart';

class VendorsState extends Equatable {
  const VendorsState({
    this.getVendorsStatus = FormzSubmissionStatus.initial,
    this.vendors = const [],
    this.next = '',
    this.searchPattern = '',
    this.hasMoreToFetch = false,
  });

  final FormzSubmissionStatus getVendorsStatus;
  final List<IdNameEntity> vendors;
  final bool hasMoreToFetch;
  final String next;
  final String searchPattern;

  VendorsState copyWith({
    FormzSubmissionStatus? getVendorsStatus,
    List<IdNameEntity>? vendors,
    String? next,
    String? searchPattern,
    bool? hasMoreToFetch,
  }) {
    return VendorsState(
      getVendorsStatus: getVendorsStatus ?? this.getVendorsStatus,
      vendors: vendors ?? this.vendors,
      next: next ?? this.next,
      searchPattern: searchPattern ?? this.searchPattern,
      hasMoreToFetch: hasMoreToFetch ?? this.hasMoreToFetch,
    );
  }

  @override
  List<Object> get props => [getVendorsStatus, vendors, next, searchPattern, hasMoreToFetch];
}
