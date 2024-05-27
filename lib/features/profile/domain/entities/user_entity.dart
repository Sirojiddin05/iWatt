class UserEntity {
  const UserEntity({
    this.fullName = '',
    this.birthDate = '',
    this.phone = '',
    this.avatar = '',
    this.gender = '',
    this.areNotificationsOn = false,
  });

  final String fullName;
  final String birthDate;
  final String phone;
  final String avatar;
  final String gender;
  final bool areNotificationsOn;

  UserEntity copyWith({String? fullName, String? birthDate, String? phone, String? avatar, String? gender, bool? areNotificationsOn}) {
    return UserEntity(
      fullName: fullName ?? this.fullName,
      birthDate: birthDate ?? this.birthDate,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      areNotificationsOn: areNotificationsOn ?? this.areNotificationsOn,
    );
  }
}
