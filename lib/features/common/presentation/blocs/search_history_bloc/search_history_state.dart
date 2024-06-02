part of 'search_history_bloc.dart';

class SearchHistoryState extends Equatable {
  final List<SearchHistoryEntity> searchHistory;
  final FormzSubmissionStatus getSearchHistoryStatus;
  final FormzSubmissionStatus postSearchHistoryStatus;
  final FormzSubmissionStatus deleteSingleSearchHistoryStatus;
  final FormzSubmissionStatus deleteAllSearchHistoryStatus;

  const SearchHistoryState({
    this.searchHistory = const [],
    this.getSearchHistoryStatus = FormzSubmissionStatus.initial,
    this.postSearchHistoryStatus = FormzSubmissionStatus.initial,
    this.deleteSingleSearchHistoryStatus = FormzSubmissionStatus.initial,
    this.deleteAllSearchHistoryStatus = FormzSubmissionStatus.initial,
  });

  SearchHistoryState copyWith({
    List<SearchHistoryEntity>? searchHistory,
    FormzSubmissionStatus? getSearchHistoryStatus,
    FormzSubmissionStatus? postSearchHistoryStatus,
    FormzSubmissionStatus? deleteSingleSearchHistoryStatus,
    FormzSubmissionStatus? deleteAllSearchHistoryStatus,
  }) {
    return SearchHistoryState(
      searchHistory: searchHistory ?? this.searchHistory,
      getSearchHistoryStatus: getSearchHistoryStatus ?? this.getSearchHistoryStatus,
      postSearchHistoryStatus: postSearchHistoryStatus ?? this.postSearchHistoryStatus,
      deleteSingleSearchHistoryStatus: deleteSingleSearchHistoryStatus ?? this.deleteSingleSearchHistoryStatus,
      deleteAllSearchHistoryStatus: deleteAllSearchHistoryStatus ?? this.deleteAllSearchHistoryStatus,
    );
  }

  @override
  List<Object> get props => [
        searchHistory,
        getSearchHistoryStatus,
        deleteSingleSearchHistoryStatus,
        deleteAllSearchHistoryStatus,
      ];
}
