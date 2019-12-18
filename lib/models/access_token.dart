
import 'package:json_annotation/json_annotation.dart';

part 'access_token.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AccessToken {

  AccessToken();

  String accessToken;
  String tokenType;
  int expiresIn;
  String privilege;

  factory AccessToken.fromJson(Map<String, dynamic> json) => _$AccessTokenFromJson(json);

}