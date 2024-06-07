import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/extensions/internet_connection.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  final Connectivity connectivity;
  bool isFirstTime = true;

  InternetBloc(this.connectivity)
      : super(const InternetState(
          status: FormzSubmissionStatus.initial,
        )) {
    subscription = connectivity.onConnectivityChanged.listen((event) async {
      if (!isFirstTime) {
        final isConnected = await connectivity.isConnected;
        add(ConnectionChanged(isConnected: isConnected));
      } else {
        isFirstTime = false;
      }
    });
    on<CheckConnectionEvent>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final isConnected = await connectivity.isConnected;
      if (isConnected) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
      add(ConnectionChanged(isConnected: isConnected));
    });

    on<ConnectionChanged>((event, emit) {
      emit(state.copyWith(isConnected: event.isConnected));
    });
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}
