part of 'change_language_bloc.dart';

abstract class ChangeLanguageEvent {
  const ChangeLanguageEvent();
}

class ChangeLanguage extends ChangeLanguageEvent {
  final String languageCode;
  final BuildContext context;
  const ChangeLanguage({required this.languageCode, required this.context});
}
