import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/enums/authentication_status.dart';
import 'package:i_watt_app/features/authorization/data/repositories_impl/authentication_repository_impl.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/get_authentication_status.dart';
import 'package:i_watt_app/service_locator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetAuthenticationStatusUseCase _statusUseCase = GetAuthenticationStatusUseCase(repository: serviceLocator<AuthenticationRepositoryImpl>());
  late StreamSubscription<AuthenticationStatus> _statusSubscription;

  AuthenticationBloc() : super(const AuthenticationState.unKnown()) {
    _statusSubscription = _statusUseCase.call(NoParams()).listen((event) {
      add(AuthenticationStatusChanged(authenticationStatus: event));
    });
    on<AuthenticationStatusChanged>((event, emit) async {
      if (event.authenticationStatus.isAuthenticated) {
        emit(const AuthenticationState.authenticated());
      } else if (event.authenticationStatus.isUnAuthenticated) {
        await StorageRepository.deleteString(StorageKeys.accessToken);
        await StorageRepository.deleteString(StorageKeys.refreshToken);
        emit(const AuthenticationState.unauthenticated());
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
