import 'package:flutter/material.dart';
import 'package:iotmasterapp/models/device.dart';
import 'package:iotmasterapp/models/device_list_model.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'base_loading_screen.dart';
import 'device_icon.dart';
import 'number_input.dart';

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
        children:
            [tempControllerSettings(model, device)].expand((i) => i).toList());
  }

  @override
  String getTitle(DeviceListModel model) {
    return model.findById(widget.deviceId).name + " settings";
  }

  @override
  void load() {}

  List<Widget> tempControllerSettings(DeviceListModel model, Device device) {
    return device.type != DeviceType.DIFF_TEMPERATURE_CONTROLLER
        ? []
        : [
            Card(
                child: SwitchListTile(
                    value: device.enabled,
                    onChanged: (value) {},
                    title: Text("Enabled"))),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text("Temperature range",
                  style: Theme.of(context).textTheme.headline6),
            ),
            Card(
                child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    max: 100,
                    incDecFactor: 0.5,
                    isInt: false,
                    subtitle: Text("Desired Temperature"))),
            Card(
                child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    max: 100,
                    incDecFactor: 0.5,
                    isInt: false,
                    subtitle: Text("Lower Temperature Threshold"))),
            Card(
                child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    max: 100,
                    incDecFactor: 0.5,
                    isInt: false,
                    subtitle: Text("Upper Temperature Threshold"))),
            Card(
                child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    max: 100,
                    incDecFactor: 0.5,
                    isInt: false,
                    subtitle: Text("Min Temperature"))),
            Card(
                child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    max: 100,
                    incDecFactor: 0.5,
                    isInt: false,
                    subtitle: Text("Max Temperature"))),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text("Cleaning",
                  style: Theme.of(context).textTheme.headline6),
            ),
            Card(
              child: InkWell(
                child: ListTile(
                    title: Text("12:33"),
                    subtitle: Text("Cleaning Start Hour"),
                    trailing: Icon(Icons.arrow_drop_down)),
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now());
                },
              ),
            ),
            Card(
                child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    max: 60,
                    subtitle: Text("Cleaning Duration (minutes)"))),
          ];
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

  doc["timezoneOffsetSeconds"] = persistentState.timezoneOffsetSeconds;

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
