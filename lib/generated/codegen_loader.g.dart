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
  "other": {
    "masculine": "Другой",
    "feminine": "Другая",
    "neuter": "Другое"
  },
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
  "males": "Мужской",
  "females": "Женский",
  "you_have_a_debt_of": "У вас имеется задолженность в размере",
  "my_cards": "Мои карты",
  "add_card": "Добавить карту",
  "notifications": "Уведомления",
  "saved_stations": "Сохраненные станции",
  "settings": "Настройки",
  "my_cars": "Мои автомобили",
  "my_stations": "Мои станции",
  "usage_instructions": "Инструкция по использованию",
  "about_us": "О нас",
  "log_out": "Выйти",
  "help": "Помощь",
  "you_saved": "Вы сэкономили",
  "km": "км",
  "login_with_qr": "Войти с QR",
  "login_to_system": "Войдите в систему!",
  "you_are_not_authorized": "Вы - не авторизованный пользователь",
  "login": "Войти",
  "interface_language": "Язык интерфейса",
  "currency": "Валюта",
  "unit": "Единица измерения",
  "car_on_map": "Автомобиль на карте",
  "app_mode": "Режим приложения",
  "light": "Светлый",
  "dark": "Темный",
  "system": "Системный",
  "delete_account": "Удалить аккаунт",
  "meter": "Метр",
  "language": "Язык",
  "white_car": "Белая машина",
  "black_car": "Черная машина",
  "red_car": "Красний кроссовер",
  "taxi": "Такси",
  "oper": "Опер",
  "sport_car": "Спорткар",
  "white_suv": "Белый внедорожник",
  "add_car": "Добавить машину",
  "no_number": "Номер не указан",
  "you_have_no_cars_yet": "У вас еще нет машины",
  "you_have_not_added_any_cars_yet": "Вы еще не добавили машину",
  "there_are_no_saved_stations": "Нет сохраненных станций",
  "you_have_not_save_stations_yet": "Вы еще не сохраняли станции",
  "delete": "Удалить",
  "edit": "Редактировать",
  "connector_types": "Типы коннекторов",
  "choose_model": "Выберите модель",
  "choose_brand": "Выберите марку",
  "connector_type": "Тип коннектора",
  "additional_information": "Доп. информация",
  "government_number_of_car": "Гос. номер машины",
  "further": "Далее",
  "helpful_information": "Полезная информация",
  "brand": {
    "capital": "Марка",
    "small": "марка"
  },
  "model": {
    "capital": "Модель",
    "small": "модель"
  },
  "car_mark_name": "Название марки автомобиля",
  "car_model_name": "Название модели",
  "input_mark": "Введите марку",
  "input_model": "Введите модель",
  "connector_type_limit": "Количество типов коннектора не может быть больше трёх",
  "if_you_enter_your_car_number_you_will_have_additional_conveniences": "Если вы введете номер своего автомобиля, у вас появятся дополнительные удобства",
  "edit_car": "Редактировать машину",
  "save": "Сохранить",
  "cancel": "Отменить",
  "mark_everything_as_read": "Отметить все  прочитанными?",
  "mark_everything_as_read_description": "Данное действие поменяет статус всех непрочитаных уведомлений на прочитанных",
  "mark": "Отметить",
  "yesterday": "Вчера",
  "product_is_developed_by_company": "Продукт разработан компанией",
  "there_was_a_problem_with_the_server_adding_the_card": "Возникла проблема с сервером, добавляющим карту.",
  "rate_app": "Оцените приложение",
  "card_added": "Карта добавлена",
  "card_not_found": "Карта не найдена",
  "card_expired": "Срок действия карты истек",
  "enter_card_correctly": "Вводите данные правильно!",
  "verification_not_right": "Код верификации введен неверно",
  "remove": "Удалить",
  "select_card": "Bыберите карту",
  "start": "Начать"
};
static const Map<String,dynamic> en = {
  "cancel": "Cancel"
};
static const Map<String,dynamic> uz = {
  "cancel": "Bekor qilish"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru, "en": en, "uz": uz};
}
