import 'package:flutter/material.dart';
import 'package:iotmasterapp/models/device.dart';
import 'package:iotmasterapp/models/device_list_model.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'base_loading_screen.dart';
import 'device_icon.dart';

class DeviceSettingsScreen extends StatefulWidget {
  DeviceSettingsScreen(this.deviceId);

  final String deviceId;

  @override
  _DeviceSettingsScreen createState() => _DeviceSettingsScreen();
}

class _DeviceSettingsScreen
    extends BaseLoadingScreen<DeviceSettingsScreen, DeviceListModel> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget render(DeviceListModel model) {
    Device device = model.findById(widget.deviceId);
    return new ListView(
        padding: const EdgeInsets.all(16),
        children: [
          tempControllerHeader(model, device)
        ].where((_) => _ != null).toList());
  }

  @override
  String getTitle(DeviceListModel model) {
    return model.findById(widget.deviceId).name + " settings";
  }

  @override
  void load() {}

  Widget tempControllerHeader(DeviceListModel model, Device device) {
    return device.type == DeviceType.THERMOSTAT
        ? //DeviceType.DIFF_TEMPERATURE_CONTROLLER ?
    Card(
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

/*
  doc["id"] = ESP.getChipId();
  doc["ip"] = WiFi.localIP().toString();
  doc["accessPoint"] = WiFi.SSID();
  doc["currentTime"] = time(nullptr);
  doc["wsConnected"] = conn.isConnected();
  doc["connectionUpdatedAt"] = conn.getConnectionUpdatedAt();
  doc["enabled"] = persistentState.enabled;
  doc["desiredTemperature"] = persistentState.desiredTemperature;
  doc["upperTemperatureThreshold"] = persistentState.upperTemperatureThreshold;
  doc["lowerTemperatureThreshold"] = persistentState.lowerTemperatureThreshold;
  doc["maxTemperature"] = persistentState.maxTemperature;
  doc["minTemperature"] = persistentState.minTemperature;
  doc["timezoneOffsetSeconds"] = persistentState.timezoneOffsetSeconds;
  doc["cleaningStartHour"] = persistentState.cleaningStartHour;
  doc["cleaningStartMinute"] = persistentState.cleaningStartMinute;
  doc["cleaningDurationMinutes"] = persistentState.cleaningDurationMinutes;
  doc["heatSourceTemperature"] = transientState.heatSourceTemperature;
  doc["heatSourceFailureCount"] = transientState.heatSourceFailureCount;
  doc["heatSourceAverageTemperature"] = transientState.heatSourceAverageTemperatureSum /  transientState.heatSourceAverageTemperatureCount;
  doc["heatSourceMaxTemperature"] = transientState.heatSourceMaxTemperature;
  doc["heatDestinationTemperature"] = transientState.heatDestinationTemperature;
  doc["heatDestinationFailureCount"] = transientState.heatDestinationFailureCount;
  doc["lastRelayStartedAt"] = transientState.lastRelayStarted;
  doc["lastRelayStartedAtMillis"] = transientState.lastRelayStartedMillis;
  doc["relayState"] = transientState.relayState;
  doc["forceRelay"] = transientState.forceRelay;
   */
}
