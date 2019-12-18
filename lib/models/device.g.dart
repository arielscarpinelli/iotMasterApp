// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TraitType _$TraitTypeFromJson(Map<String, dynamic> json) {
  return TraitType()
    ..requiresActionTopic = json['requiresActionTopic'] as bool
    ..requiresStatusTopic = json['requiresStatusTopic'] as bool
    ..type = json['type'] as String
    ..actionTopic = json['actionTopic'] as String
    ..statusTopic = json['statusTopic'] as String;
}

Map<String, dynamic> _$TraitTypeToJson(TraitType instance) => <String, dynamic>{
      'requiresActionTopic': instance.requiresActionTopic,
      'requiresStatusTopic': instance.requiresStatusTopic,
      'type': instance.type,
      'actionTopic': instance.actionTopic,
      'statusTopic': instance.statusTopic
    };

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..type = _$enumDecodeNullable(_$DeviceTypeEnumMap, json['type'])
    ..traits = (json['traits'] as List)
        ?.map((e) =>
            e == null ? null : TraitType.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..twofa = json['twofa'] as String
    ..twofaPin = json['twofaPin'] as String;
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$DeviceTypeEnumMap[instance.type],
      'traits': instance.traits,
      'twofa': instance.twofa,
      'twofaPin': instance.twofaPin
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$DeviceTypeEnumMap = <DeviceType, dynamic>{
  DeviceType.Light: 'Light',
  DeviceType.Outlet: 'Outlet',
  DeviceType.Switch: 'Switch',
  DeviceType.Scene: 'Scene',
  DeviceType.Thermostat: 'Thermostat',
  DeviceType.Fan: 'Fan',
  DeviceType.AC: 'AC',
  DeviceType.Purifier: 'Purifier',
  DeviceType.Sprinkler: 'Sprinkler',
  DeviceType.Door: 'Door',
  DeviceType.Blinds: 'Blinds',
  DeviceType.Shutter: 'Shutter',
  DeviceType.Dishwasher: 'Dishwasher',
  DeviceType.Dryer: 'Dryer',
  DeviceType.Vacuum: 'Vacuum',
  DeviceType.Washer: 'Washer',
  DeviceType.Camera: 'Camera'
};
