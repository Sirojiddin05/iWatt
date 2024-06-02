import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/search_history_entity.dart';
import 'package:i_watt_app/features/common/domain/usecases/delete_all_search_histories.dart';
import 'package:i_watt_app/features/common/domain/usecases/delete_single_search_history.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_search_history.dart';
import 'package:i_watt_app/features/common/domain/usecases/post_search_history_usecase.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final PostSearchHistoryUseCase postSearchHistoryUseCase;
  final GetSearchHistoryUseCase getSearchHistoryUseCase;
  final DeleteSingleSearchHistoryUseCase deleteSingleSearchHistoryUseCase;
  final DeleteAllSearchHistoryUseCase deleteAllSearchHistoryUseCase;

  SearchHistoryBloc({
    required this.getSearchHistoryUseCase,
    required this.postSearchHistoryUseCase,
    required this.deleteSingleSearchHistoryUseCase,
    required this.deleteAllSearchHistoryUseCase,
  }) : super(const SearchHistoryState()) {
    on<GetSearchHistoryEvent>((event, emit) async {
      emit(state.copyWith(getSearchHistoryStatus: FormzSubmissionStatus.inProgress));

      final result = await getSearchHistoryUseCase.call(NoParams());
      if (result.isRight) {
        emit(
          state.copyWith(
            getSearchHistoryStatus: FormzSubmissionStatus.success,
            searchHistory: result.right.results,
          ),
        );
      } else {
        emit(state.copyWith(getSearchHistoryStatus: FormzSubmissionStatus.failure));
      }
    });
    on<PostSearchHistoryEvent>((event, emit) async {
      emit(state.copyWith(postSearchHistoryStatus: FormzSubmissionStatus.inProgress));
      final result = await postSearchHistoryUseCase.call(event.locationId);
      if (result.isRight) {
        emit(state.copyWith(
          postSearchHistoryStatus: FormzSubmissionStatus.success,
          searchHistory: [...state.searchHistory, result.right],
        ));
      } else {
        emit(state.copyWith(postSearchHistoryStatus: FormzSubmissionStatus.failure));
      }
    });
    on<DeleteAllSearchHistoryEvent>((event, emit) async {
      emit(state.copyWith(getSearchHistoryStatus: FormzSubmissionStatus.inProgress, searchHistory: []));
      final result = await deleteAllSearchHistoryUseCase.call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(deleteAllSearchHistoryStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(getSearchHistoryStatus: FormzSubmissionStatus.failure));
      }
    });
    on<DeleteSingleSearchHistoryEvent>((event, emit) async {
      final searchHistory = state.searchHistory.where((element) => element.id != event.id).toList();
      emit(state.copyWith(
          deleteSingleSearchHistoryStatus: FormzSubmissionStatus.inProgress, searchHistory: [...searchHistory]));
      final result = await deleteSingleSearchHistoryUseCase.call(event.id);
      if (result.isRight) {
        emit(state.copyWith(deleteAllSearchHistoryStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(getSearchHistoryStatus: FormzSubmissionStatus.failure));
      }
    });
  }
}
