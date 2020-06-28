import 'package:flutter/widgets.dart';
import 'package:iotmasterapp/models/protocol_message.dart';
import 'package:iotmasterapp/service/iotmaster_api.dart';
import 'package:provider/provider.dart';

import 'base_loading_model.dart';
import 'device.dart';
import 'login_model.dart';

class DeviceListModel extends BaseLoadingModel<List<Device>> {
  IotMasterApi api;
  BuildContext context;

  Map<String, Device> byId;

  bool updatingDevice = false;
  String updateDeviceError;

  DeviceListModel(IotMasterApi api, BuildContext context) {
    this.api = api;
    this.context = context;
  }

  @protected
  set data(List<Device> devices) {
    super.data = devices;
    if (devices != null) {
      byId = Map.fromIterable(devices, key: (d) => d.deviceid);
    }
  }

  fetchDevices() async {
    fetch(api.listDevices(
        Provider.of<LoginModel>(this.context, listen: false).data));
  }

  Device findById(String deviceId) {
    return byId[deviceId];
  }

  void switchOn(String deviceId, bool on) async {
    var device = findById(deviceId);
    var message = device.switchOnMessage(on);
    return sendMessageToDevice(message, device);
  }

  Future sendMessageToDevice(ProtocolMessage message, Device device) async {
    updatingDevice = true;
    updateDeviceError = null;
    notifyListeners();
    try {
      var result = await api.send(
          Provider.of<LoginModel>(this.context, listen: false).data, message);
      device.updateWith(result);
      notifyListeners();
    } on DeviceOfflineException {
      device.online = false;
      notifyListeners();
    } catch (e) {
      updateDeviceError = e.toString();
    }
  }
}
