import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityResult? _connectivityResult;

  ConnectivityResult? get connectivityResult => _connectivityResult;

  Future<ConnectivityResult> fetchConnectivityResult() async {
    final connectivity = Connectivity();
    final result = await connectivity.checkConnectivity();
    _connectivityResult = result;
    notifyListeners();
    return result;
  }
}
