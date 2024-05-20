import 'package:connectivity_plus/connectivity_plus.dart';

extension InternetConnection on Connectivity {
  Future<bool> get isConnected async {
    final connectionInfo = await checkConnectivity();

    return connectionInfo.contains(ConnectivityResult.wifi) ||
        connectionInfo.contains(ConnectivityResult.mobile) ||
        connectionInfo.contains(ConnectivityResult.ethernet);
  }
}
