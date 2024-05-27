import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/profile/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<GetUserData>((event, emit) async {
      emit(state.copyWith(getUserDataStatus: FormzSubmissionStatus.inProgress));
      await Future.delayed(const Duration(milliseconds: 200));
      if (true) {
        emit(
          state.copyWith(
            getUserDataStatus: FormzSubmissionStatus.success,
            user: const UserEntity(
              fullName: 'John Doe',
              phone: '+998 77 774-77-44',
              avatar:
                  'https://cdn.britannica.com/73/234573-050-8EE03E16/Cristiano-Ronaldo-ceremony-rename-airport-Santa-Cruz-Madeira-Portugal-March-29-2017.jpg',
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            getUserDataStatus: FormzSubmissionStatus.failure,
            getUserDataErrorMessage: 'Error',
          ),
        );
      }
    });
  }
}
