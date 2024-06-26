import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/common/domain/entities/get_vendors_params_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_vendors_usecase.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:rxdart/rxdart.dart';

part 'vendors_event.dart';
part 'vendors_state.dart';

class VendorsBloc extends Bloc<VendorsEvent, VendorsState> {
  final GetVendorsUseCase getVendorsUseCase;
  VendorsBloc(this.getVendorsUseCase) : super(const VendorsState()) {
    on<GetVendorsEvent>(_getVendors, transformer: debounce(const Duration(milliseconds: 300)));
    on<GetMoreVendorsEvent>(_getMoreVendors);
    on<SearchVendorsEvent>(_setSearchPattern);
  }
  void _getVendors(GetVendorsEvent event, Emitter<VendorsState> emit) async {
    emit(state.copyWith(getVendorsStatus: FormzSubmissionStatus.inProgress));
    final result = await getVendorsUseCase(
      GetVendorsParams(next: '', searchPattern: state.searchPattern),
    );
    if (result.isRight) {
      final vendors = [...result.right.results];
      if (state.searchPattern.isEmpty) {
        vendors.insert(0, IdNameEntity(id: 0, name: LocaleKeys.select_all.tr(), logo: AppIcons.selectAll));
      }
      emit(
        state.copyWith(
          getVendorsStatus: FormzSubmissionStatus.success,
          vendors: vendors,
          next: result.right.next,
          hasMoreToFetch: result.right.next != null,
        ),
      );
    } else {
      emit(
        state.copyWith(getVendorsStatus: FormzSubmissionStatus.failure, hasMoreToFetch: false),
      );
    }
  }

  void _getMoreVendors(GetMoreVendorsEvent event, Emitter<VendorsState> emit) async {
    final result = await getVendorsUseCase(
      GetVendorsParams(next: state.next, searchPattern: state.searchPattern),
    );
    if (result.isRight) {
      emit(
        state.copyWith(
          vendors: [...state.vendors, ...result.right.results],
          next: result.right.next,
          hasMoreToFetch: result.right.next != null,
        ),
      );
    } else {
      emit(state.copyWith(hasMoreToFetch: false));
    }
  }

  void _setSearchPattern(SearchVendorsEvent event, Emitter<VendorsState> emit) {
    emit(state.copyWith(searchPattern: event.searchPattern));
    if (event.searchPattern.length >= 3 || event.searchPattern.isEmpty) {
      add(GetVendorsEvent());
    }
  }

  EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) => (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
