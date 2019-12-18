import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

enum DeviceType {
  Light,
  Outlet,
  Switch,
  Scene,
  Thermostat,
  Fan,
  AC,
  Purifier,
  Sprinkler,
  Door,
  Blinds,
  Shutter,
  Dishwasher,
  Dryer,
  Vacuum,
  Washer,
  Camera
}

@JsonSerializable()
class TraitType {
  TraitType();

  bool requiresActionTopic;
  bool requiresStatusTopic;
  String type;
  String actionTopic;
  String statusTopic;

  factory TraitType.fromJson(Map<String, dynamic> json) =>
      _$TraitTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TraitTypeToJson(this);
}

@JsonSerializable()
class Device {
  Device();

  // Unique device id, assigned by gBridge
  int id;

  // Human readable name, used for voice commands
  String name;

  DeviceType type;

  //Traits/ Features the device supports. Choose at least one.
  List<TraitType> traits;

  // Two-step confirmation or PIN-Code verification. null means no further confirmation is used.
  String twofa;

  // PIN code for two step authorization. Necessary if twofa is set to pin. The PIN code is usually a 4 to 8 digit number.
  String twofaPin;

  factory Device.fromJson(Map<String, dynamic> json) {
    Device device = _$DeviceFromJson(json);
    if (json.containsKey('device_id')) {
      device.id = json['device_id'] as int;
    }
    return device;
  }

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
