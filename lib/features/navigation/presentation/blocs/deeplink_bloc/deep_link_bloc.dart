import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_constants.dart';

part 'deep_link_event.dart';
part 'deep_link_state.dart';

class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  static const dlStream = EventChannel('${AppConstants.shareUrl}events');
  static const platform = MethodChannel('${AppConstants.shareUrl}channel');
  final StreamController<String> _stateController = StreamController();
  Stream<String> get dlState => _stateController.stream;
  Sink<String> get stateSink => _stateController.sink;

  DeepLinkBloc() : super(DeepLinkInitial()) {
    startUri().then(_onRedirected);
    dlStream.receiveBroadcastStream().listen((d) => _onRedirected(d));
    on<DeepLinkChanged>((event, emit) {
      emit(DeepLinkInitial());
      final uri = event.uri;
      if (uri.contains(AppConstants.shareUrl)) {
        final parsedSlug = uri.replaceAll('${AppConstants.shareUrl}location/', '');
        final locationId = int.tryParse(parsedSlug) ?? 0;
        emit(ChargeLocationScanned(locationId));
      }
    });
  }

  void _onRedirected(String uri) {
    add(DeepLinkChanged(uri: uri));
    stateSink.add(uri);
  }

  Future<String> startUri() async {
    try {
      final link = await platform.invokeMethod('deeplink');
      add(DeepLinkChanged(uri: link));
      return link;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}
