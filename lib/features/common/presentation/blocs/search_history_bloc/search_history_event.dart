part of 'search_history_bloc.dart';

@immutable
abstract class SearchHistoryEvent {}

class GetSearchHistoryEvent extends SearchHistoryEvent {}

class PostSearchHistoryEvent extends SearchHistoryEvent {
  final int locationId;

  PostSearchHistoryEvent(this.locationId);
}

class DeleteSingleSearchHistoryEvent extends SearchHistoryEvent {
  final int id;

  DeleteSingleSearchHistoryEvent(this.id);
}

class DeleteAllSearchHistoryEvent extends SearchHistoryEvent {}
