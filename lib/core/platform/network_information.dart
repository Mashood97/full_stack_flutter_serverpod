import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity networkConnectionCheck;

  NetworkInfoImpl({required this.networkConnectionCheck});

  @override
  Future<bool> get isConnected async =>
      await networkConnectionCheck.checkConnectivity() !=
      ConnectivityResult.none;
}
