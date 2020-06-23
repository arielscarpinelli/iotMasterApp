import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

enum DeviceType {
  LIGHT,
  SWITCH,
  THERMOSTAT,
  GENERIC
}

DeviceType fromType(String type) {
  switch(type) {
    case "LIGHT":
      return DeviceType.LIGHT;
    case "SWITCH":
      return DeviceType.SWITCH;
    case "THERMOSTAT":
      return DeviceType.THERMOSTAT;
    default:
      return DeviceType.GENERIC;
  }
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

  List<String> traits;


  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
