import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/profile/data/models/user_model.dart';
import 'package:i_watt_app/features/profile/domain/entities/user_entity.dart';
import 'package:i_watt_app/features/profile/domain/usecases/get_user_data_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserDataUseCase getUserDataUseCase;
  final UpdateProfileDataUseCase updateProfileDataUseCase;

  ProfileBloc(this.getUserDataUseCase, this.updateProfileDataUseCase) : super(const ProfileState()) {
    on<GetUserData>((event, emit) async {
      emit(state.copyWith(getUserDataStatus: FormzSubmissionStatus.inProgress));
      final result = await getUserDataUseCase.call(NoParams());
      if (result.isRight) {
        emit(
          state.copyWith(
            getUserDataStatus: FormzSubmissionStatus.success,
            user: result.right,
          ),
        );
      } else {
        emit(
          state.copyWith(
            getUserDataStatus: FormzSubmissionStatus.failure,
            getUserDataErrorMessage: result.left.errorMessage,
          ),
        );
      }
    });
    on<UpdateProfile>((event, emit) async {
      final oldUser = state.user;
      final newUser = state.user.copyWith(
        fullName: event.fullName,
        isNotificationEnabled: event.isNotificationEnabled,
        dateOfBirth: event.dateOfBirth,
        language: event.language,
        phone: event.phone,
        photo: event.photo,
        gender: event.gender,
      );
      emit(state.copyWith(
        getUserDataStatus: FormzSubmissionStatus.inProgress,
        user: newUser,
      ));
      final result = await updateProfileDataUseCase.call(UserModel(
        fullName: newUser.fullName,
        phone: newUser.phone,
        photo: newUser.photo,
        gender: newUser.gender,
        dateOfBirth: newUser.dateOfBirth,
        language: newUser.language,
        notificationCount: newUser.notificationCount,
        isNotificationEnabled: newUser.isNotificationEnabled,
        balance: newUser.balance,
      ));
      if (result.isRight) {
        emit(
          state.copyWith(
            updateProfileStatus: FormzSubmissionStatus.success,
            getUserDataStatus: FormzSubmissionStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            user: oldUser,
            updateProfileStatus: FormzSubmissionStatus.failure,
            updateErrorMessage: result.left.errorMessage,
          ),
        );
      }
    });
    on<UpdateProfileLocally>((event, emit) async {
      final oldUser = state.user;
      final newUser = state.user.copyWith(
        fullName: event.fullName,
        isNotificationEnabled: event.isNotificationEnabled,
        balance: event.balance,
        dateOfBirth: event.dateOfBirth,
        language: event.language,
        notificationCount: event.notificationCount,
        phone: event.phone,
        photo: event.photo,
      );
      emit(state.copyWith(user: newUser));
    });
  }
}
