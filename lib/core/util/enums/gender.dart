import 'package:i_watt_app/generated/locale_keys.g.dart';

enum Gender {
  male(LocaleKeys.males),
  female(LocaleKeys.females);

  final String title;

  const Gender(this.title);
}
