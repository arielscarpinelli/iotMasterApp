import 'package:flutter/material.dart';
import 'package:iotmasterapp/models/device.dart';
import 'package:iotmasterapp/models/device_list_model.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'base_loading_screen.dart';
import 'device_icon.dart';
import 'device_settings_screen.dart';

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
    var deviceOffline = !device.online;
    return new ListView(
        padding: const EdgeInsets.all(16),
        children: deviceOffline
            ? [_buildHeader(device), offline()]
            : [
                _buildHeader(device),
                error(model, device),
                onOff(model, device),
                tempControllerHeader(model, device)
              ].where((_) => _ != null).toList());
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

  Widget tempControllerHeader(DeviceListModel model, Device device) {
    return device.type == DeviceType.DIFF_TEMPERATURE_CONTROLLER
        ? Card(
            child: Column(
            children: <Widget>[
              ListTile(
                  leading: Icon(MdiIcons.coolantTemperature),
                  title: Text("26.5ºC",
                      style: Theme.of(context).textTheme.headline2),
                  subtitle: Text("Water temperature")),
              ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text("32.5ºC"),
                  subtitle: Text("Collector temperature")),
              ListTile(
                  leading: Icon(MdiIcons.engineOutline),
                  title: Text("Running"),
                  subtitle: Text("Pump status")),
            ],
          ))
        : null;
  }

  Widget error(DeviceListModel model, Device device) {
    // TODO: display any errors on the device
    return null;
  }

  @override
  List<Widget> getAppBarActions(DeviceListModel model) {
    Device device = model.findById(widget.deviceId);
    return <Widget>[
      device.canBeConfigured
          ? IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                return Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (ctx) =>
                            DeviceSettingsScreen(widget.deviceId)));
              },
            )
          : null
    ].where((_) => _ != null).toList();
  }
}
