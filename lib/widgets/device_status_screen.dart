import 'package:flutter/material.dart';
import 'package:iotmasterapp/models/device.dart';
import 'package:iotmasterapp/models/device_list_model.dart';
import 'package:provider/provider.dart';

import 'base_loading_screen.dart';
import 'device_icon.dart';

class DeviceStatusScreen extends StatefulWidget {
  DeviceStatusScreen(this.deviceId);

  final String deviceId;

  @override
  _DeviceStatusScreen createState() => _DeviceStatusScreen();
}

class _DeviceStatusScreen
    extends BaseLoadingScreen<DeviceStatusScreen, DeviceListModel> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget render(DeviceListModel model) {
    Device device = model.findById(widget.deviceId);
    return new ListView(
        padding: const EdgeInsets.all(16),
        children: !device.online
            ? [_buildHeader(device), offline()]
            : [_buildHeader(device), onOff(model, device)]
                .where((_) => _ != null)
                .toList());
  }

  Widget _buildHeader(Device device) {
    return Card(
        child: InkWell(
      child: ListTile(
        leading: DeviceIcon(device.type),
        title: Text(device.name, style: _biggerFont),
        subtitle: Text(device.friendlyType),
      ),
    ));
  }

  @override
  String getTitle(DeviceListModel model) {
    return model.findById(widget.deviceId).name;
  }

  @override
  void load() {}

  Widget onOff(DeviceListModel model, Device device) {
    return device.canTurnOn
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                    child: device.isOn
                        ? new FlatButton(
                            onPressed: () =>
                                model.switchOn(device.deviceid, false),
                            child: Text("On"),
                            color: Theme.of(context).primaryColor,
                            textTheme: ButtonTextTheme.primary)
                        : new OutlineButton(
                            onPressed: () =>
                                model.switchOn(device.deviceid, true),
                            child: Text("Off"))))))
        : null;
  }

  Widget offline() {
    return Card(
        child: InkWell(
      child: ListTile(
        leading: Icon(Icons.error_outline),
        title: Text("Offline"),
      ),
    ));
  }
}
