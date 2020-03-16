import 'dart:convert';

import 'package:iotmasterapp/models/access_token.dart';
import 'package:iotmasterapp/models/device.dart';
import 'package:http/http.dart' as http;

class IotMasterApi {
  static String host = "https://gbridge.kappelt.net/api/v2/";

  // "http://localhost:8081/api/v2/";

  Future<AccessToken> login(String apiKey) async {
    final response = await http.post(host + "auth/token",
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({'apikey': apiKey}));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return AccessToken.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to login - ' + response.body);
    }
  }

  Future<List<Device>> listDevices(AccessToken token) async {
    final response = await http.get(
      host + "device",
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

  Future<Device> getDevice(AccessToken token, int deviceId) async {
    final response = await http.get(
      host + "device/" + deviceId.toString(),
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
}
