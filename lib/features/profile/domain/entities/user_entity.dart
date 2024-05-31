class UserEntity {
  const UserEntity({
    this.id = -1,
    this.fullName = '',
    this.dateOfBirth = '',
    this.phone = '',
    this.photo = '',
    this.gender = '',
    this.isNotificationEnabled = false,
    this.notificationCount = 0,
    this.language = 'uz',
    this.balance = '',
  });

  final int id;
  final String fullName;
  final String photo;
  final String phone;
  final String balance;
  final String dateOfBirth;
  final String language;
  final int notificationCount;
  final String gender;
  final bool isNotificationEnabled;

  UserEntity copyWith({
    String? fullName,
    String? photo,
    String? phone,
    String? balance,
    String? dateOfBirth,
    String? language,
    int? notificationCount,
    bool? isNotificationEnabled,
  }) {
    return UserEntity(
      id: id,
      fullName: fullName ?? this.fullName,
      photo: photo ?? this.photo,
      phone: phone ?? this.phone,
      balance: balance ?? this.balance,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      language: language ?? this.language,
      notificationCount: notificationCount ?? this.notificationCount,
      isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
    );
  }
}
