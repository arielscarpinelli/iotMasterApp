// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProtocolMessage _$ProtocolMessageFromJson(Map<String, dynamic> json) {
  return ProtocolMessage()
    ..sequence = json['sequence'] as String
    ..action = _$enumDecodeNullable(_$ActionEnumMap, json['action'])
    ..apikey = json['apikey'] as String
    ..deviceid = json['deviceid'] as String
    ..params = json['params'] as Map<String, dynamic>
    ..error = json['error'] as int
    ..reason = json['reason'] as String;
}

Map<String, dynamic> _$ProtocolMessageToJson(ProtocolMessage instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'action': _$ActionEnumMap[instance.action],
      'apikey': instance.apikey,
      'deviceid': instance.deviceid,
      'params': instance.params,
      'error': instance.error,
      'reason': instance.reason,
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

const _$ActionEnumMap = {
  Action.update: 'update',
  Action.query: 'query',
  Action.register: 'register',
  Action.date: 'date',
};
