import 'package:uide/domain/data_provider/token_data_provider.dart';

class MainAppModel {
  final _tokenDataProvider = TokenDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final token = await _tokenDataProvider.getToken();
    _isAuth = token != null;
  }
}
