// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) {
  return AccessToken()
    ..accessToken = json['access_token'] as String
    ..tokenType = json['token_type'] as String
    ..expiresIn = json['expires_in'] as int
    ..privilege = json['privilege'] as String;
}

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'privilege': instance.privilege,
    };
