import 'package:i_watt_app/generated/locale_keys.g.dart';

enum Gender {
  male(LocaleKeys.male),
  female(LocaleKeys.female);

  final String title;

  const Gender(this.title);
}
