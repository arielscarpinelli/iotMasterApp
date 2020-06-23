import 'package:iotmasterapp/service/iotmaster_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'access_token.dart';
import 'base_loading_model.dart';

class LoginModel extends BaseLoadingModel<AccessToken> {
  IotMasterApi api;

  String _user;
  String _password;

  LoginModel(IotMasterApi api) {
    this.api = api;
  }

  login(String user, String password) async {
    this._user = user;
    this._password = password;
    fetch(_doLogin());
  }

  Future<AccessToken> _doLogin() async {
    var jwt = await api.login(_user, _password);
    _saveRefreshToken();
    return jwt;
  }

  bool get loggedIn {
    return this.data != null &&
        this.data.expiresIn > DateTime.now().millisecondsSinceEpoch;
  }

  // TODO: insecure
  tryRecoverLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get("user");
    String password = prefs.get("password");
    if (user != null && user.isNotEmpty && password != null && password.isNotEmpty) {
      return login(user, password);
    }
  }

  _saveRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.wait([
        prefs.setString("user", _user),
        prefs.setString("password", _password)
    ]);
  }
}
