part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetUserData extends ProfileEvent {}

class DeleteAccount extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String? fullName;
  final String? photo;
  final String? phone;
  final String? balance;
  final String? dateOfBirth;
  final String? language;
  final int? notificationCount;
  final String? gender;
  final bool? isNotificationEnabled;

  UpdateProfile({
    this.fullName,
    this.photo,
    this.phone,
    this.balance,
    this.dateOfBirth,
    this.language,
    this.notificationCount,
    this.gender,
    this.isNotificationEnabled,
  });
}

class UpdateProfileLocally extends ProfileEvent {
  final String? fullName;
  final String? photo;
  final String? phone;
  final String? balance;
  final String? dateOfBirth;
  final String? language;
  final int? notificationCount;
  final String? gender;
  final bool? isNotificationEnabled;

  UpdateProfileLocally({
    this.fullName,
    this.photo,
    this.phone,
    this.balance,
    this.dateOfBirth,
    this.language,
    this.notificationCount,
    this.gender,
    this.isNotificationEnabled,
  });
}

class DecrementNotificationCount extends ProfileEvent {
  DecrementNotificationCount();
}
