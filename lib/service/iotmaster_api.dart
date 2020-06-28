import 'dart:convert';

import 'package:iotmasterapp/models/access_token.dart';
import 'package:iotmasterapp/models/device.dart';
import 'package:http/http.dart' as http;
import 'package:iotmasterapp/models/protocol_message.dart';

class IotMasterApi {
  static String host = "https://api.iotmaster.dev/api/";

  // "http://localhost:8081/api/v2/";

  Future<AccessToken> login(String email, String password) async {

    // TODO: call specialized endpoint

    final response = await http.post(host + "user/login",
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({'email': email, 'password': password}));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      var decoded = json.decode(response.body);
      decoded['access_token'] = decoded['jwt'];
      AccessToken token = AccessToken.fromJson(decoded);
      token.expiresIn = DateTime.now().millisecondsSinceEpoch + (3600 * 1000);
      return token;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to login - ' + response.body);
    }
  }

  Future<List<Device>> listDevices(AccessToken token) async {
    final response = await http.get(
      host + "user/device/",
      headers: {
        'Authorization': 'Bearer ' + token.accessToken,
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return (json.decode(response.body) as List)
          .map((d) => Device.fromJson(d))
          .toList(growable: false);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to get devices - ' + response.body);
    }
  }

  Future<Device> getDevice(AccessToken token, String deviceId) async {
    final response = await http.get(
      host + "user/device/" + deviceId.toString(),
      headers: {
        'Authorization': 'Bearer ' + token.accessToken,
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Device.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to get device ' +
          deviceId.toString() +
          ' - ' +
          response.body);
    }
  }

  Future<ProtocolMessage> send(AccessToken token, ProtocolMessage message) async {

    final body = json.encode(message.toJson());

    final response = await http.post(
      host + "http",
      headers: {
        'Authorization': 'Bearer ' + token.accessToken,
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: body
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return ProtocolMessage.fromJson(json.decode(response.body));
    } else if (response.statusCode == 503) {
      throw new DeviceOfflineException(message.deviceid);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to update device - ' + response.body);
    }
  }
}

class DeviceOfflineException implements Exception {
  DeviceOfflineException(String deviceid);
}
