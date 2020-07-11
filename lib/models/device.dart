import 'package:flutter/foundation.dart';
import 'package:iotmasterapp/models/protocol_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

enum DeviceType {
  LIGHT,
  SWITCH,
  THERMOSTAT,
  DIFF_TEMPERATURE_CONTROLLER,
  GENERIC
}

const switchableDevicesTypes = {DeviceType.LIGHT, DeviceType.SWITCH};

enum KnownTraits {
  OnOff
}

abstract class Params {
  static const on = "on";
}

@JsonSerializable()
class Device {

  Device();

  String deviceid;

  String apikey;

  String name;

  String group;

  @JsonKey(unknownEnumValue: DeviceType.GENERIC)
  DeviceType type;

  DateTime createdAt;

  bool online;

  Map<String, dynamic> params;

  Map<String, dynamic> attributes;

  Set<String> traits;

  String get friendlyType => describeEnum(type).toLowerCase();

  bool get isOn {
    return params[Params.on] ?? false;
  }

  bool get canTurnOn {
    return switchableDevicesTypes.contains(type) || traits.contains(KnownTraits.OnOff.toString());
  }

  bool get canBeConfigured {
    return DeviceType.DIFF_TEMPERATURE_CONTROLLER == type;
  }

  bool get enabled {
    return true; // TODO
  }

  factory Device.fromJson(Map<String, dynamic> json) {
    var d = _$DeviceFromJson(json);
    if (d.type == DeviceType.THERMOSTAT) {
      d.online = true;
      d.type = DeviceType.DIFF_TEMPERATURE_CONTROLLER;
    }
    return d;
  }

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  ProtocolMessage switchOnMessage(bool on) {
    ProtocolMessage message = new ProtocolMessage();
    message.deviceid = deviceid;
    message.apikey = apikey;
    message.params = {
      Params.on: on
    };

    return message;
  }

  void updateWith(ProtocolMessage result) {
    if (result.error != 0) {
      throw new Exception('Failed to update device - ' + result.reason);
    }

    params.addAll(result.params);

  }
}
