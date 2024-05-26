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
  "other": "Другое",
  "map": "Карта",
  "stations": "Станции",
  "charging_processes": "Зарядки",
  "profile": "Профиль",
  "no_network": "Нет сети",
  "check_connection": "Проверьте соединение",
  "check_connection_and_update": "Проверьте соединение с интернетом или \nпопробуйте обновить",
  "refresh_the_page": "Обновите страницу",
  "server_problems": "Неполадки с сервером",
  "request_canceled": "Запрос отменен",
  "free": "Свободен",
  "busy": "Занят",
  "does_not_work": "Не работает",
  "search": "Поиск",
  "clear": "Очистить",
  "filter": "Фильтр",
  "power": "Мощность",
  "confirm": "Подтвердить",
  "apply": "Применить",
  "turn_on": "Включить",
  "location_access_disabled": "Доступ к GPS не включен",
  "more_details": "Подробнее",
  "parking_fees_apply": "Взимается плата за парковку",
  "there_are_not_stations": "Нет станций",
  "there_is_nothing_here_yet": "Пока тут ничего нет",
  "failure_in_loading": "Ошибка при загрузке",
  "filter_is_active": "Фильтр активирован.",
  "station": {
    "singular": "станция",
    "plural_nominative": "станции",
    "plural_genitive": "станций"
  },
  "search_stations": "Поиск электростанции",
  "input_for_search": "Введите для поиска",
  "recent_requests": "Недавние запросы",
  "find_station": "Найти станцию",
  "you_can_find_the_nearest_charging_station_by_pressing_the_current_button": "Вы можете найти самую близкую зарядную станцию, нажав текущую кнопку",
  "nothing_found": "Ничего не найдено",
  "nothing_found_to_your_request": "По вашему запросу ничего не найдено",
  "authorization": "Авторизация",
  "you_need_input_phone_number_for_login": "Для вход в аккаунт вам нужно ввести свой номер телефона",
  "resume": "Продолжить",
  "verification_code": "Код верификации",
  "authorization_through_qr": "Авторизация через QR-код",
  "input_code": "Введите код",
  "send_code_again_after": "Отправить код снова через:",
  "we_send_otp_to_your_phone": "Мы вам отправили одноразовый код подтверждения на ваш номер",
  "error": "Ошибка",
  "too_many_attempts": "Слишком много попыток",
  "you_entered_wrong_code_three_times": "Вы неправильно ввели код верификации 3 раза в связи с чем заблокированы на {} минут",
  "support_service_number": "Номер телефона службы поддержки",
  "qr_authorization": "QR Авторизация",
  "in_order_to_login_scan_qr_code": "Чтобы зайти по QR-коду, сканируйте QR-код",
  "registration": "Регистрация",
  "input_necessary_fields": "Введите необходимые информации для создание нового аккаунта",
  "full_name": "Полное имя",
  "input_full_name": "Введите полное имя",
  "birth_date": "Дата рождения",
  "dd_mm_yyyy": "дд.мм.гггг",
  "your_gender": "Ваш пол",
  "select_date": "Выберите дату",
  "male": "Мужской",
  "female": "Женский"
};
static const Map<String,dynamic> en = {};
static const Map<String,dynamic> uz = {};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru, "en": en, "uz": uz};
}
