import 'package:flutter/widgets.dart';
import 'package:iotmasterapp/service/iotmaster_api.dart';
import 'package:provider/provider.dart';

import 'base_loading_model.dart';
import 'device.dart';
import 'login_model.dart';

class DeviceListModel extends BaseLoadingModel<List<Device>> {

  IotMasterApi api;
  BuildContext context;

  DeviceListModel(IotMasterApi api, BuildContext context) {
    this.api = api;
    this.context = context;
  }


  fetchDevices() async {
    fetch(api.listDevices(Provider.of<LoginModel>(this.context, listen: false).data));
  }

}