import 'package:flutter/widgets.dart';
import 'package:gbridgeapp/service/gbridge_api.dart';
import 'package:provider/provider.dart';

import 'base_loading_model.dart';
import 'device.dart';
import 'login_model.dart';

class DeviceListModel extends BaseLoadingModel<List<Device>> {

  GBridgeApi api;
  BuildContext context;

  DeviceListModel(GBridgeApi api, BuildContext context) {
    this.api = api;
    this.context = context;
  }


  fetchDevices() async {
    fetch(api.listDevices(Provider.of<LoginModel>(this.context, listen: false).data));
  }

}