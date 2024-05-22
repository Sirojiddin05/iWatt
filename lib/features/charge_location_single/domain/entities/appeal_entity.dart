class AppealEntity {
  const AppealEntity({this.title = '', this.id = -1});

  final int id;
  final String title;

  AppealEntity copyWith({int? id, String? title}) {
    return AppealEntity(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
