import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:esptouch_flutter/esptouch_flutter.dart';

import 'base_loading_model.dart';

class WifiData {
  String ssid;
  String bssid;
  String ip;
}

class AddDeviceModel extends BaseLoadingModel<WifiData> {
  String wifiPassword;
  String lastSsid;

  bool scanning = false;
  String deviceIp;
  var scanError;
  StreamSubscription<ESPTouchResult> streamSubscription;

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
    /*
    result.ssid = await Connectivity().getWifiName();
    result.bssid = await Connectivity().getWifiBSSID();
    */
    result.ssid = "Pau y Ari";
    result.bssid = "b0:fc:36:7b:76:60";
    result.ip = await Connectivity().getWifiIP();

    if (result.ssid != lastSsid) {
      wifiPassword = null;
    }

    return result;
  }

  checkConnectivity() async {
    fetch(_doFetchConnectivity());
  }

  scanDevice(String password) {
    this.wifiPassword = password;
    this.lastSsid = data.ssid;

    final ESPTouchTask task = ESPTouchTask(
      ssid: data.ssid,
      bssid: data.bssid,
      password: password,
    );

    scanError = null;
    scanning = true;

    notifyListeners();

    final Stream<ESPTouchResult> stream = task.execute();

    streamSubscription = stream.listen((result) {
      scanning = false;
      deviceIp = result.ip;
      streamSubscription.cancel();
      notifyListeners();
    }, onError: (err) {
      scanning = false;
      scanError = err;
      notifyListeners();
    }, cancelOnError: true);
  }

  void cancel() {
    if (streamSubscription != null) {
      streamSubscription.cancel();
    }
    scanning = false;
    scanError = null;
    deviceIp = null;
    notifyListeners();
  }
}
