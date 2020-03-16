import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iotmasterapp/models/device.dart';

class DeviceIcon extends StatelessWidget {

  const DeviceIcon(this.deviceType, {Key key}) : super(key: key);

  final DeviceType deviceType;

  @override
  Widget build(BuildContext context) {
    return Icon(getIcon(deviceType));
  }

}

IconData getIcon(DeviceType deviceType) {

  switch (deviceType) {
    case DeviceType.Light:
      return Icons.lightbulb_outline;
    case DeviceType.Thermostat:
      return Icons.wb_sunny;
    default:
      return Icons.widgets;
  }
}
