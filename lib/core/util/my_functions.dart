import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MyFunctions {
  const MyFunctions._();

  static String getBalanceMessage(String myBalance) {
    String balance = myBalance.replaceAll(' ', '');
    balance = balance.replaceAll('-', '');
    balance = balance.split('.').first;
    return '-${formatNumber(balance)}';
  }

  static String formatNumber(String number) {
    final rNumber = number.replaceAll(' ', '').replaceAll('.', '').split('').reversed.join();
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

  static String getCarNumberType(int type) =>
      CarNumberType.values.firstWhereOrNull((e) => e.type.contains(type))?.value ?? '';

  static String getFormattedDate(DateTime dateTime) {
    return DateFormat("dd.MM.yyyy").format(dateTime).toString();
  }

  static String getFormattedTime(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays == 1) {
      return LocaleKeys.yesterday.tr();
    } else if (difference.inDays > 1) {
      return DateFormat('dd MMM yyyy').format(dateTime).toLowerCase();
    } else {
      return '${difference.inSeconds} ago';
    }
  }

  static String getFormattedTimerTime(int ticks) {
    final buffer = StringBuffer();
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
    if (isGreater) {
      return true;
    }
    return false;
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
    final distance = Geolocator.distanceBetween(
        firstPoint.latitude, firstPoint.longitude, secondPoint.latitude, secondPoint.longitude);
    return distance;
  }

  // static List<ConnectorStatus> getConnectorStatuses(ChargeLocationEntity location) {
  //   final stations = location.chargePoints;
  //   final connectors = stations.expand((element) => element.connectors).toList();
  //   final List<ConnectorStatus?> listOfConnectorStatuses = List.generate(connectors.length, (i) {
  //     final status = getConnectorStatus(connectors[i].status);
  //     if (status != null && status.isBooked) {
  //       return ConnectorStatus.busy;
  //     }
  //     return status;
  //   });
  //   listOfConnectorStatuses.retainWhere((element) => element != null);
  //   final List<ConnectorStatus> list =
  //       List.generate(listOfConnectorStatuses.length, (index) => listOfConnectorStatuses[index]!);
  //   return list;
  // }

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
    canvas.drawImage(
        await getImageInfo(context, image).then((value) => value.image), offset ?? const Offset(0, 0), paint);

    if (shouldAddText) {
      TextPainter painter = TextPainter(textDirection: ui.TextDirection.ltr);
      painter.text = TextSpan(
        text: placeCount.toString(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 46, color: AppColors.cyprus),
      );
      painter.layout();
      painter.paint(canvas, Offset((width * (placeCount > 9 ? 0.44 : 0.46)) - painter.width * 0.34, (height * 0.28)));
    } else if (statuses.isNotEmpty) {
      final x = width / 2;
      final y = shouldAddBackCircle ? height / 2.25 : height / 2.7;
      Rect rect = Rect.fromCircle(center: Offset(x, y), radius: 56);
      final List<Paint> paints = List.generate(statuses.length, (index) {
        final paint = Paint();
        paint.style = PaintingStyle.stroke;
        paint.strokeCap = StrokeCap.round;
        paint.strokeWidth = 8;
        if (withLuminosity) {
          paint.color = _adjustSaturation(statuses[index].color, -1);
        } else {
          paint.color = statuses[index].color;
        }
        return paint;
      });

      const availableSpace = 2 * pi;
      const indentSingleLength = pi / 12;
      final indentFullLength = statuses.length * indentSingleLength;
      final lengthOfStatus = (availableSpace - indentFullLength) / statuses.length;
      double startAngle = (3 * pi / 2) + (indentSingleLength / 2);
      for (int i = 0; i < statuses.length; i++) {
        canvas.drawArc(
            rect,
            startAngle,
            lengthOfStatus, // Sweep angle (adjust as needed)
            false,
            paints[i]);
        startAngle = startAngle + lengthOfStatus + indentSingleLength;
      }
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

  static Color _adjustSaturation(Color color, double saturationFactor) {
    List<double> hsl = _rgbToHsl(color);
    double newSaturation = (hsl[1] * saturationFactor).clamp(0.0, 1.0);
    return _hslToRgb(hsl[0], newSaturation, hsl[2]);
  }

  static List<double> _rgbToHsl(Color color) {
    double r = color.red / 255.0;
    double g = color.green / 255.0;
    double b = color.blue / 255.0;
    double maximum = max(r, max(g, b));
    double minimum = min(r, min(g, b));
    late double h, s, l;
    l = (maximum + minimum) / 2.0;

    if (maximum == minimum) {
      h = 0.0;
      s = 0.0;
    } else {
      double d = maximum - minimum;
      s = l > 0.5 ? d / (2.0 - maximum - minimum) : d / (maximum + minimum);
      if (maximum == r) {
        h = (g - b) / d + (g < b ? 6 : 0);
      } else if (maximum == g) {
        h = (b - r) / d + 2;
      } else if (maximum == b) {
        h = (r - g) / d + 4;
      }
      h /= 6;
    }

    return [h, s, l];
  }

  static Color _hslToRgb(double h, double s, double l) {
    double r, g, b;

    if (s == 0.0) {
      r = g = b = l; // Achromatic
    } else {
      double hue2rgb(double p, double q, double t) {
        if (t < 0.0) t += 1.0;
        if (t > 1.0) t -= 1.0;
        if (t < 1.0 / 6.0) return p + (q - p) * 6.0 * t;
        if (t < 1.0 / 2.0) return q;
        if (t < 2.0 / 3.0) return p + (q - p) * (2.0 / 3.0 - t) * 6.0;
        return p;
      }

      double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      double p = 2 * l - q;
      r = hue2rgb(p, q, h + 1.0 / 3.0);
      g = hue2rgb(p, q, h);
      b = hue2rgb(p, q, h - 1.0 / 3.0);
    }

    return Color.fromRGBO((r * 255).round(), (g * 255).round(), (b * 255).round(), 1);
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
      mapId: const MapObjectId('user_location'),
    );

    return newMarker;
  }
}
