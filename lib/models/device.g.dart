// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device()
    ..deviceid = json['deviceid'] as String
    ..apikey = json['apikey'] as String
    ..name = json['name'] as String
    ..group = json['group'] as String
    ..type = _$enumDecodeNullable(_$DeviceTypeEnumMap, json['type'],
        unknownValue: DeviceType.GENERIC)
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..online = json['online'] as bool
    ..params = json['params'] as Map<String, dynamic>
    ..attributes = json['attributes'] as Map<String, dynamic>
    ..traits = (json['traits'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'deviceid': instance.deviceid,
      'apikey': instance.apikey,
      'name': instance.name,
      'group': instance.group,
      'type': _$DeviceTypeEnumMap[instance.type],
      'createdAt': instance.createdAt?.toIso8601String(),
      'online': instance.online,
      'params': instance.params,
      'attributes': instance.attributes,
      'traits': instance.traits,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DeviceTypeEnumMap = {
  DeviceType.LIGHT: 'LIGHT',
  DeviceType.SWITCH: 'SWITCH',
  DeviceType.THERMOSTAT: 'THERMOSTAT',
  DeviceType.GENERIC: 'GENERIC',
};
