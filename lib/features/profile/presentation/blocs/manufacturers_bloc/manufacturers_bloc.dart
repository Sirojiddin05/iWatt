import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/profile/domain/entities/get_manufacturers_param_entity.dart';
import 'package:i_watt_app/features/profile/domain/usecases/get_manufacturers_usecase.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:meta/meta.dart';

part 'manufacturers_event.dart';
part 'manufacturers_state.dart';

class ManufacturersBloc extends Bloc<ManufacturersEvent, ManufacturersState> {
  final GetManufacturersUseCase getManufacturersUseCase;
  ManufacturersBloc(this.getManufacturersUseCase) : super(const ManufacturersState()) {
    on<SearchManufacturers>((event, emit) {
      emit(state.copyWith(searchQuery: event.searchQuery));
      add(GetManufacturers());
    });
    on<GetManufacturers>((event, emit) async {
      emit(state.copyWith(getManufacturers: FormzSubmissionStatus.inProgress));
      final result = await getManufacturersUseCase(GetManufacturersParamEntity(searchQuery: state.searchQuery));
      if (result.isRight) {
        final newList = [...result.right.results];
        if (result.right.next == null) {
          newList.add(IdNameEntity(id: 0, name: "${LocaleKeys.other_feminine.tr()} ${LocaleKeys.brand_small.tr()}"));
        }
        emit(state.copyWith(
          getManufacturers: FormzSubmissionStatus.success,
          manufacturers: [...newList],
          next: result.right.next,
          fetchMore: result.right.next != null && result.right.next!.isNotEmpty,
        ));
      } else {
        emit(
          state.copyWith(
            getManufacturers: FormzSubmissionStatus.failure,
            error: result.left.errorMessage,
          ),
        );
      }
    });
    on<GetMoreManufacturers>((event, emit) async {
      final result = await getManufacturersUseCase(GetManufacturersParamEntity(next: state.next));
      if (result.isRight) {
        final oldList = state.manufacturers;
        final newList = result.right.results;
        if (result.right.next == null) {
          newList.add(IdNameEntity(id: 0, name: "${LocaleKeys.other_feminine.tr()} ${LocaleKeys.brand_small.tr()}"));
        }
        emit(state.copyWith(
          getManufacturers: FormzSubmissionStatus.success,
          manufacturers: [
            ...oldList,
            ...newList,
          ],
          next: result.right.next,
        ));
      } else {
        emit(
          state.copyWith(
            error: result.left.errorMessage,
          ),
        );
      }
    });
  }
}
