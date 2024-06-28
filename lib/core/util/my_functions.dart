import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/enums/app_theme.dart';
import 'package:i_watt_app/core/util/enums/car_number_type.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/core/util/enums/location_permission_status.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:i_watt_app/service_locator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MyFunctions {
  const MyFunctions._();

  static double getRadiusFromZoom(double zoom) {
    return 40000 / pow(2, zoom) > 1 ? 40000 / pow(2, zoom) : 1;
  }

  static Future<String?> getEncryptionKey() async {
    final key = await secureStorage.read(key: StorageKeys.encryptionKey);
    return key;
  }

  static String getNotificationCreatedTime(String locale, String createdAt) {
    final dateTime = DateTime.parse(createdAt).toLocal();
    Duration difference = DateTime.now().difference(dateTime);
    final years = difference.inDays ~/ 365;
    final days = difference.inDays;
    final hours = difference.inHours;
    final minutes = difference.inMinutes;
    if (years > 0) {
      return DateFormat(MyFunctions.getFullDatePattern(locale), locale).format(dateTime).toString();
    } else if (days > 7) {
      return DateFormat(MyFunctions.getFullDatePattern(locale), locale).format(dateTime).toString();
    } else if (days > 1 && days <= 7) {
      return DateFormat(MyFunctions.getWeekDayTimePattern(locale), locale).format(dateTime).toString();
    } else if (days == 1) {
      return DateFormat(MyFunctions.getYesterdayTimePattern(locale), locale).format(dateTime).toString();
    } else if (hours >= 1) {
      return MyFunctions.geHoursAgoPattern(locale, hours);
    } else if (minutes >= 1) {
      return MyFunctions.geMinutesAgoPattern(locale, minutes);
    } else {
      if (locale == 'uz') {
        return 'Hozirgina';
      }
      if (locale == 'ru') {
        return 'Только что';
      }
      return 'Just now';
    }
  }

  static String geMinutesAgoPattern(String locale, int minutesAgo) {
    if (locale == 'uz') {
      return "$minutesAgo daqiqa oldin";
    }
    if (locale == 'ru') {
      return "$minutesAgo мин. назад";
    }
    return "$minutesAgo minutes ago";
  }

  static String geHoursAgoPattern(String locale, int hoursAgo) {
    if (locale == 'uz') {
      return "$hoursAgo soat oldin";
    }
    if (locale == 'ru') {
      return "$hoursAgo ч. назад";
    }
    return "$hoursAgo hours ago";
  }

  static String getYesterdayTimePattern(String locale) {
    if (locale == 'uz') {
      return "'Kecha' HH:mm 'da'";
    }
    if (locale == 'ru') {
      return "'Вчера' в HH:mm";
    }
    return "'Yesterday' 'at' HH:mm";
  }

  static String getWeekDayTimePattern(String locale) {
    if (locale == 'uz') {
      return "EEEE HH:mm 'da'";
    }
    if (locale == 'ru') {
      return "EEEE 'в' HH:mm";
    }
    return "EEEE 'at' HH:mm";
  }

  static String getMonthTimePattern(String locale) {
    if (locale == 'uz') {
      return "d MMMM HH:mm 'da'";
    }
    if (locale == 'ru') {
      return "d MMMM 'в' HH:mm ";
    }
    return "MMMM M 'at' HH:mm a";
  }

  static String getFullDatePattern(String locale) {
    if (locale == 'uz') {
      return "d MMMM y 'yil'";
    }
    if (locale == 'ru') {
      return "d MMMM y 'г.'";
    }
    return "MMMM M, y";
  }

  static String getPrice(String price) {
    final p = price.split('.').toList().first.split(',').toList().first;
    return '${formatNumber(p)} UZS';
  }

  static String getParkingTitle(bool isPayedParkingStarted) {
    if (!isPayedParkingStarted) {
      return LocaleKeys.payed_parking_will_start;
    } else {
      return LocaleKeys.payed_parking_is_going;
    }
  }

  static List<int> getDifferenceBetweenTwoDates(String firstDate, String secondDate) {
    final time = List<int>.filled(5, 0);
    final first = DateTime.parse(firstDate);
    final second = DateTime.parse(secondDate);
    final difference = second.difference(first);
    final days = difference.inDays;
    final hours = difference.inHours;
    final minutes = difference.inMinutes - hours * 60;
    final seconds = difference.inSeconds - hours * 3600 - minutes * 60;
    final milliseconds = difference.inMilliseconds - hours * 3600000 - minutes * 60000 - seconds * 1000;
    time[0] = days;
    time[1] = hours;
    time[2] = minutes;
    time[3] = seconds;
    time[4] = milliseconds;
    return time;
  }

  static String getDaysDueToQuantity(int quantity) {
    final isLastDigitOne = quantity % 10 == 1;
    if (isLastDigitOne && quantity != 11) {
      return LocaleKeys.day_singular_nominative;
    }
    final isLastDigitTwo = quantity % 10 == 2;
    final isLastDigitThree = quantity % 10 == 3;
    final isLastDigitFour = quantity % 10 == 4;
    final isBetweenTenAndTwenty = quantity > 10 && quantity < 20;
    if ((isLastDigitTwo || isLastDigitThree || isLastDigitFour) && !isBetweenTenAndTwenty) {
      return LocaleKeys.day_singular_genitive;
    }
    return LocaleKeys.day_plural_genitive;
  }

  static String getHoursDueToQuantity(int quantity) {
    final isLastDigitOne = quantity % 10 == 1;
    if (isLastDigitOne && quantity != 11) {
      return LocaleKeys.hour_singular_nominative;
    }
    final isLastDigitTwo = quantity % 10 == 2;
    final isLastDigitThree = quantity % 10 == 3;
    final isLastDigitFour = quantity % 10 == 4;
    final isBetweenTenAndTwenty = quantity > 10 && quantity < 20;
    if ((isLastDigitTwo || isLastDigitThree || isLastDigitFour) && !isBetweenTenAndTwenty) {
      return LocaleKeys.hour_singular_genitive;
    }
    return LocaleKeys.hour_plural_genitive;
  }

  static String getMinutesDueToQuantity(int quantity) {
    final isLastDigitOne = quantity % 10 == 1;
    if (isLastDigitOne && quantity != 11) {
      return LocaleKeys.minute_singular_nominative;
    }
    final isLastDigitTwo = quantity % 10 == 2;
    final isLastDigitThree = quantity % 10 == 3;
    final isLastDigitFour = quantity % 10 == 4;
    final isBetweenTenAndTwenty = quantity > 10 && quantity < 20;
    if ((isLastDigitTwo || isLastDigitThree || isLastDigitFour) && !isBetweenTenAndTwenty) {
      return LocaleKeys.minute_plural_nominative;
    }
    return LocaleKeys.minute_plural_genitive;
  }

  static String getSecondsDueToQuantity(int quantity) {
    final isLastDigitOne = quantity % 10 == 1;
    if (isLastDigitOne && quantity != 11) {
      return LocaleKeys.second_singular_nominative;
    }
    final isLastDigitTwo = quantity % 10 == 2;
    final isLastDigitThree = quantity % 10 == 3;
    final isLastDigitFour = quantity % 10 == 4;
    final isBetweenTenAndTwenty = quantity > 10 && quantity < 20;
    if ((isLastDigitTwo || isLastDigitThree || isLastDigitFour) && !isBetweenTenAndTwenty) {
      return LocaleKeys.second_plural_nominative;
    }
    return LocaleKeys.second_plural_genitive;
  }

  static String getEventTime(String dateTime) {
    if (dateTime.isEmpty) {
      return '';
    }
    final parsed = DateTime.parse(dateTime);
    DateFormat();
    final time = DateFormat("hh:mm").format(parsed).toString();
    final date = DateFormat("dd.MM.yyyy").format(parsed).toString();
    return '$time, $date';
  }

  static String getBalanceMessage(String myBalance) {
    String balance = myBalance.replaceAll(' ', '');
    balance = balance.replaceAll('-', '');
    balance = balance.split('.').first;
    return '${myBalance.contains('-') ? '-' : ''}${formatNumber(balance)}';
  }

  static String formatNumber(String number) {
    final rNumber = number.replaceAll(' ', '').replaceAll('.', '').replaceAll(',', '').split('').reversed.join();
    String formatted = '';
    for (int i = 0; i < rNumber.length; i++) {
      if ((i + 1) % 3 == 0 && i != rNumber.length - 1) {
        formatted = ' ${rNumber[i]}$formatted';
      } else {
        formatted = rNumber[i] + formatted;
      }
    }
    return formatted;
  }

  static String getNameOfCar(String name, String customName) {
    if (name.isNotEmpty) {
      return name;
    }
    return customName;
  }

  static int carNumberType(String number) {
    if (RegExp("^[0-9]{2}[A-Z]{1}[0-9]{3}[A-Z]{2}\$").hasMatch(number)) {
      return 1;
    } else if (RegExp("^[0-9]{5}[A-Z]{3}\$").hasMatch(number)) {
      return 2;
    } else if (RegExp("^UN[0-9]{4}\$").hasMatch(number)) {
      return 3;
    } else if (RegExp("^CMD[0-9]{4}\$").hasMatch(number)) {
      return 4;
    } else if (RegExp("^T[0-9]{6}\$").hasMatch(number)) {
      return 5;
    } else if (RegExp("^[0-9]{2}M[0-9]{4,6}\$").hasMatch(number)) {
      return 6;
    } else if (RegExp("^[0-9]{2}H[0-9]{4,6}\$").hasMatch(number)) {
      return 7;
    }
    return 0;
  }

  static String getCarNumberType(int type) => CarNumberType.values.firstWhereOrNull((e) => e.type.contains(type))?.value ?? '';

  static String getFormattedDate(DateTime dateTime) {
    return DateFormat("dd.MM.yyyy").format(dateTime).toString();
  }

  static String getFormattedTime(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays == 1) {
      return LocaleKeys.yesterday.tr();
    } else if (difference.inDays < 1) {
      return DateFormat('dd.MMM.yyyy').format(dateTime).toLowerCase();
    } else {
      return '${difference.inSeconds} ago';
    }
  }

  static String getFormattedTimerTime(int ticks, {bool includeHours = false}) {
    final buffer = StringBuffer();
    if (includeHours) {
      final hours = (ticks / 3600).floor();
      if (hours < 10) {
        buffer.write('0');
      }
      buffer.write(hours);
      buffer.write(':');
    }
    final minutes = (ticks / 60).floor();
    if (minutes < 10) {
      buffer.write('0');
    }
    buffer.write(minutes);
    buffer.write(':');
    final seconds = (ticks % 60).floor();
    if (seconds < 10) {
      buffer.write('0');
    }
    buffer.write(seconds);
    return buffer.toString();
  }

  static String getStationDueToQuantity(int quantity) {
    final isLastDigitOne = quantity % 10 == 1;
    if (isLastDigitOne && quantity != 11) {
      return LocaleKeys.station_singular;
    }
    final isLastDigitTwo = quantity % 10 == 2;
    final isLastDigitThree = quantity % 10 == 3;
    final isLastDigitFour = quantity % 10 == 4;
    final isBetweenTenAndTwenty = quantity > 10 && quantity < 20;
    if ((isLastDigitTwo || isLastDigitThree || isLastDigitFour) && !isBetweenTenAndTwenty) {
      return LocaleKeys.station_plural_nominative;
    }
    return LocaleKeys.station_plural_genitive;
  }

  static Future<bool> needToUpdate(String newVersion) async {
    final isValidNumber = isValidVersionNumber(newVersion);
    if (!isValidNumber) {
      return false;
    }
    final isGreater = await isNewVersionGreater(newVersion);
    return isGreater;
  }

  static bool isValidVersionNumber(String newVersion) => RegExp('^[0-9].[0-9].[0-9]').hasMatch(newVersion);

  static Future<bool> isNewVersionGreater(String newVersion) async {
    final cV = await currentVersionAsync;
    final newVersionList = newVersion.split('.');
    final currentVersionList = cV.split('.');
    for (int i = 0; i < newVersionList.length; i++) {
      if (int.parse(newVersionList[i]) > int.parse(currentVersionList[i])) {
        return true;
      }
    }
    return false;
  }

  static Future<String> get currentVersionAsync async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    await StorageRepository.putString(StorageKeys.currentAppVersion, currentVersion);
    return currentVersion;
  }

  static String getCurrentVersionSync() {
    final version = StorageRepository.getString(StorageKeys.currentAppVersion);
    return 'V $version';
  }

  static String getChargeTypeIconByStatus(String name, [String? status]) {
    String title = name.replaceAll(' ', '').replaceAll('/', '');
    if (title == 'NACSAC(Tesla)') {
      title = title.replaceAll('NACSAC(Tesla)', 'CHadeMO');
    }
    if (title == 'NACSDC(Tesla)') {
      title = title.replaceAll('NACSDC(Tesla)', 'CHadeMO');
    }
    if (title == 'GBTAC') {
      title = title.replaceAll('GBTAC', 'TYPE2');
    }
    if (title.contains('charging')) {
      return 'assets/app_icons/charge_type_icons/${title.replaceAll('charging', '')}/charging.svg';
    }
    final ConnectorStatus? s = getConnectorStatus(status);
    switch (s) {
      case ConnectorStatus.free:
        return 'assets/app_icons/charge_type_icons/$title/free.svg';
      case ConnectorStatus.busy:
        return 'assets/app_icons/charge_type_icons/$title/busy.svg';
      case ConnectorStatus.notWorking:
        return 'assets/app_icons/charge_type_icons/$title/not_working.svg';
      case ConnectorStatus.booked:
        return 'assets/app_icons/charge_type_icons/$title/busy.svg';
      default:
        return 'assets/app_icons/charge_type_icons/$title/default.svg';
    }
  }

  static ThemeMode getThemeMode() {
    final themeMode = StorageRepository.getString(StorageKeys.themeMode);
    if (themeMode == 'light') {
      return ThemeMode.light;
    }
    if (themeMode == 'dark') {
      return ThemeMode.dark;
    }
    if (themeMode == 'system') {
      return ThemeMode.system;
    }
    return ThemeMode.system;
  }

  static AppTheme getAppTheme() {
    final themeMode = StorageRepository.getString(StorageKeys.themeMode);
    if (themeMode == 'light') {
      return AppTheme.light;
    }
    if (themeMode == 'dark') {
      return AppTheme.dark;
    }
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final theme = brightness == Brightness.light ? AppTheme.light : AppTheme.dark;
    return theme;
  }

  static double getDistanceBetweenTwoPoints(Point firstPoint, Point secondPoint) {
    final distance = Geolocator.distanceBetween(firstPoint.latitude, firstPoint.longitude, secondPoint.latitude, secondPoint.longitude);
    return distance;
  }

  static ConnectorStatus getConnectorStatus(String? status) {
    switch (status) {
      case 'Available':
        return ConnectorStatus.free;
      case 'Charging':
        return ConnectorStatus.busy;
      case 'Finishing':
        return ConnectorStatus.busy;
      case 'Reserved':
        return ConnectorStatus.booked;
      case 'SuspendedEVSE':
        return ConnectorStatus.notWorking;
      case 'SuspendedEV':
        return ConnectorStatus.notWorking;
      case 'Faulted':
        return ConnectorStatus.notWorking;
      case 'Preparing':
        return ConnectorStatus.free;
      case 'Unavailable':
        return ConnectorStatus.notWorking;
      default:
        return ConnectorStatus.notWorking;
    }
  }

  static Future<Uint8List> getBytesFromCanvas({
    required int width,
    required int height,
    int placeCount = 0,
    required BuildContext context,
    Offset? offset,
    required String image,
    bool shouldAddText = false,
    bool shouldAddShadow = true,
    bool shouldAddBackCircle = false,
    bool withLuminosity = false,
    List<ConnectorStatus> statuses = const [],
  }) async {
    final pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    if (shouldAddShadow) {
      Rect rect = Rect.fromCircle(center: Offset(width / 2, height / 2), radius: 8);
      canvas.drawShadow(Path()..addRRect(RRect.fromRectXY(rect, 0, 0)), AppColors.limeGreen, 18, false);
    }
    final Paint paint = Paint()..color = Colors.red;
    canvas.drawImage(await getImageInfo(context, image).then((value) => value.image), offset ?? const Offset(0, 0), paint);

    if (shouldAddText) {
      TextPainter painter = TextPainter(textDirection: ui.TextDirection.ltr);
      painter.text = TextSpan(
        text: placeCount.toString(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 46, color: AppColors.cyprus),
      );
      painter.layout();
      painter.paint(canvas, Offset((width * (placeCount > 9 ? 0.44 : 0.46)) - painter.width * 0.34, (height * 0.28)));
    }

    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data?.buffer.asUint8List() ?? Uint8List(0);
  }

  static Future<ImageInfo> getImageInfo(BuildContext context, String image) async {
    AssetImage assetImage = AssetImage(image);
    ImageStream stream = assetImage.resolve(createLocalImageConfiguration(context));
    Completer<ImageInfo> completer = Completer();
    stream.addListener(ImageStreamListener((ImageInfo imageInfo, _) {
      return completer.complete(imageInfo);
    }));
    return completer.future;
  }

  static Future<Uint8List?> createImageFromWidget(
    Widget widget, {
    Size? logicalSize,
    Size? imageSize,
  }) async {
    final repaintBoundary = RenderRepaintBoundary();
    logicalSize ??= ui.window.physicalSize / ui.window.devicePixelRatio;
    imageSize ??= ui.window.physicalSize;
    assert(logicalSize.aspectRatio == imageSize.aspectRatio, 'logicalSize and imageSize must not be the same');
    final renderView = RenderView(
      // window: ui.window,
      child: RenderPositionedBox(alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(
        devicePixelRatio: 1,
        logicalConstraints: BoxConstraints.tight(logicalSize),
      ),
      view: ui.window,
    );
    final pipelineOwner = PipelineOwner();
    final buildOwner = BuildOwner(focusManager: FocusManager());
    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();
    final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
        container: repaintBoundary,
        child: Directionality(
          textDirection: ui.TextDirection.ltr,
          child: widget,
        )).attachToRenderTree(buildOwner);
    // final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    //   container: repaintBoundary,
    //   child: widget,
    // ).attachToRenderTree(buildOwner);
    buildOwner.buildScope(rootElement);
    buildOwner
      ..buildScope(rootElement)
      ..finalizeTree();
    pipelineOwner
      ..flushLayout()
      ..flushCompositingBits()
      ..flushPaint();
    final image = await repaintBoundary.toImage(pixelRatio: imageSize.width / logicalSize.width);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  static Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition();
    } on Exception {
      return null;
    }
  }

  static Future<LocationPermissionStatus> getWhetherPermissionGranted() async {
    try {
      final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        return LocationPermissionStatus.locationServiceDisabled;
      } else {
        final geoPermission = await Geolocator.checkPermission();
        if (geoPermission == LocationPermission.denied || geoPermission == LocationPermission.deniedForever) {
          final permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
            return LocationPermissionStatus.permissionGranted;
          } else {
            return LocationPermissionStatus.permissionDenied;
          }
        }
        if (geoPermission == LocationPermission.always || geoPermission == LocationPermission.whileInUse) {
          return LocationPermissionStatus.permissionGranted;
        } else {
          return LocationPermissionStatus.permissionDenied;
        }
      }
    } on Exception {
      return LocationPermissionStatus.permissionDenied;
    }
  }

  static Future<MapObject> getMyIcon({
    required BuildContext context,
    required Function(PlacemarkMapObject object, Point point) onObjectTap,
    required Point value,
    required String userIcon,
  }) async {
    final pictureRecorder = ui.PictureRecorder();

    final iconData = await MyFunctions.getBytesFromCanvas(
        width: 180, height: 214, image: userIcon, context: context, offset: const Offset(0, 0), shouldAddShadow: false);
    final newMarker = PlacemarkMapObject(
      opacity: 1,
      onTap: onObjectTap,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromBytes(iconData),
          scale: 1,
        ),
      ),
      point: Point(latitude: value.latitude, longitude: value.longitude),
      mapId: MapObjectId(userIcon),
    );

    return newMarker;
  }
}
