import 'package:flutter/foundation.dart';
import 'package:iotmasterapp/models/protocol_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

enum DeviceType {
  LIGHT,
  SWITCH,
  THERMOSTAT,
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

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

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
