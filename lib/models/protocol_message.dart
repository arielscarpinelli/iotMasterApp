import 'package:json_annotation/json_annotation.dart';

part 'protocol_message.g.dart';

enum Action {
  update,
  query,
  register,
  date
}

@JsonSerializable()
class ProtocolMessage {

  ProtocolMessage();

  String sequence = DateTime.now().millisecondsSinceEpoch.toString();

  Action action = Action.update;
  String apikey;
  String deviceid;
  Map<String, dynamic> params;

  int error;
  String reason;

  factory ProtocolMessage.fromJson(Map<String, dynamic> json) => _$ProtocolMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ProtocolMessageToJson(this);
}