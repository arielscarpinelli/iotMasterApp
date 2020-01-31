import 'package:gbridgeapp/service/gbridge_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'access_token.dart';
import 'base_loading_model.dart';

class LoginModel extends BaseLoadingModel<AccessToken> {
  GBridgeApi api;

  String _apiKey;

  LoginModel(GBridgeApi api) {
    this.api = api;
  }

  login(String user, String ignoredPassword) async {
    this._apiKey = user;
    fetch(_doLogin());
  }

  Future<AccessToken> _doLogin() async {
    var jwt = await api.login(_apiKey);
    jwt.expiresIn = DateTime.now().millisecondsSinceEpoch + (jwt.expiresIn * 1000);
    _saveApiKey();
    return jwt;
  }

  bool get loggedIn {
    return this.data != null &&
        this.data.expiresIn > DateTime.now().millisecondsSinceEpoch;
  }

  // TODO: insecure
  tryRecoverLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.get("apiKey");
    if (apiKey != null && apiKey.isNotEmpty) {
      return login(apiKey, null);
    }
  }

  _saveApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("apiKey", _apiKey);
  }
}
