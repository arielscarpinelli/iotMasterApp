import 'dart:io';

import 'package:connectivity/connectivity.dart';

import 'base_loading_model.dart';

class WifiData {
  String ssid;
  String bssid;
  String ip;
}

class WifiModel extends BaseLoadingModel<WifiData> {
  _checkLocationIfNeeded() async {
    if (Platform.isIOS) {
      var status = await Connectivity().requestLocationServiceAuthorization();

      switch (status) {
        case LocationAuthorizationStatus.authorizedWhenInUse:
        case LocationAuthorizationStatus.authorizedAlways:
          break;
        default:
          throw new Exception("must enable location to detect WiFi");
      }
    } else if (Platform.isAndroid) {
      // TODO: Enable GPS
    }
  }

  Future<WifiData> _doFetchConnectivity() async {
    await _checkLocationIfNeeded();

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.wifi) {
      throw new Exception("Please connect to WiFi first");
    }

    WifiData result = new WifiData();
    result.ssid = await Connectivity().getWifiName();
    result.bssid = await Connectivity().getWifiBSSID();
    result.ip = await Connectivity().getWifiIP();

    return result;
  }

  checkConnectivity() async {
    fetch(_doFetchConnectivity());
  }
}
