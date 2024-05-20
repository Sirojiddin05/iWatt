// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ru = {
  "map": "Карта",
  "stations": "Станции",
  "charging_processes": "Зарядки",
  "profile": "Профиль",
  "no_network": "Нет сети",
  "check_connection": "Проверьте соединение",
  "check_connection_and_update": "Проверьте соединение с интернетом или \nпопробуйте обновить",
  "refresh_the_page": "Обновите страницу",
  "server_problems": "Неполадки с сервером",
  "request_canceled": "Запрос отменен"
};
static const Map<String,dynamic> en = {};
static const Map<String,dynamic> uz = {};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru, "en": en, "uz": uz};
}
