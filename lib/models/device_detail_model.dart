import 'package:flutter/widgets.dart';
import 'package:gbridgeapp/service/gbridge_api.dart';
import 'package:provider/provider.dart';

import 'base_loading_model.dart';
import 'device.dart';
import 'login_model.dart';

class DeviceDetailModel extends BaseLoadingModel<Device> {
  GBridgeApi api;
  BuildContext context;

  DeviceDetailModel(GBridgeApi api, BuildContext context) {
    this.api = api;
    this.context = context;
  }

  fetchDevice(int deviceId) async {
    fetch(api.getDevice(
        Provider.of<LoginModel>(this.context, listen: false).data, deviceId));
  }
}
