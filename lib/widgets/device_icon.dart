import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iotmasterapp/models/device.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    case DeviceType.LIGHT:
      return Icons.lightbulb_outline;
    case DeviceType.SWITCH:
      return MdiIcons.lightSwitch;
    case DeviceType.THERMOSTAT:
    case DeviceType.DIFF_TEMPERATURE_CONTROLLER:
      return Icons.wb_sunny;
    default:
      return Icons.widgets;
  }
}
