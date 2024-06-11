import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/enums/authentication_status.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/get_authentication_status.dart';
import 'package:i_watt_app/features/common/domain/usecases/register_device_id_key_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetAuthenticationStatusUseCase _statusUseCase;
  late StreamSubscription<AuthenticationStatus> _statusSubscription;
  final RegisterDeviceIdAndKeyUseCase registerDeviceUseCase;

  AuthenticationBloc(this._statusUseCase, this.registerDeviceUseCase) : super(const AuthenticationState.unKnown()) {
    _statusSubscription = _statusUseCase.call(NoParams()).listen((event) {
      add(AuthenticationStatusChanged(authenticationStatus: event, isRebuild: true));
    });
    on<AuthenticationStatusChanged>((event, emit) async {
      if (event.authenticationStatus.isAuthenticated) {
        registerDeviceAndKey();
        await StorageRepository.putBool(key: StorageKeys.isRegisteredOnce, value: true);
        emit(AuthenticationState.authenticated(event.isRebuild));
      } else if (event.authenticationStatus.isUnAuthenticated) {
        await StorageRepository.deleteString(StorageKeys.accessToken);
        await StorageRepository.deleteString(StorageKeys.refreshToken);
        emit(AuthenticationState.unauthenticated(event.isRebuild));
      } else if (event.authenticationStatus.isUnKnown) {
        emit(const AuthenticationState.unKnown());
      }
    });
  }

  Future<void> registerDeviceAndKey() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final device = DeviceInfoPlugin();
    late final String? deviceId;
    late final String type;
    if (Platform.isAndroid) {
      final info = await device.androidInfo;
      deviceId = info.id;
      debugPrint('deviceId: $deviceId');
      type = 'android';
    } else {
      final info = await device.iosInfo;
      deviceId = info.identifierForVendor;
      debugPrint('deviceId: $deviceId');
      type = 'ios';
    }
    await registerDeviceUseCase.call(
      RegisterDeviceIdAndKeyParamsEntity(
        registrationId: fcmToken ?? '',
        deviceId: deviceId,
        deviceType: type,
      ),
    );
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
