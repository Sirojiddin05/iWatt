import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/enums/authentication_status.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/get_authentication_status.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetAuthenticationStatusUseCase _statusUseCase;
  late StreamSubscription<AuthenticationStatus> _statusSubscription;

  AuthenticationBloc(this._statusUseCase) : super(const AuthenticationState.unKnown()) {
    _statusSubscription = _statusUseCase.call(NoParams()).listen((event) {
      add(AuthenticationStatusChanged(authenticationStatus: event, isRebuild: true));
    });
    on<AuthenticationStatusChanged>((event, emit) async {
      if (event.authenticationStatus.isAuthenticated) {
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

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
