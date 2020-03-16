import 'package:flutter/material.dart';
import 'package:iotmasterapp/models/add_device_model.dart';
import 'package:provider/provider.dart';

import 'base_loading_screen.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  _AddDeviceScreen createState() => _AddDeviceScreen();
}

class _AddDeviceScreen
    extends BaseLoadingScreen<AddDeviceScreen, AddDeviceModel> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final ssid = TextEditingController();
  final password = TextEditingController();

  AddDeviceModel model;

  @override
  Widget render(AddDeviceModel model) {
    this.model = model;
    ssid.text = model.data.ssid;
    password.text = model.wifiPassword;

    final ssidField = TextField(
      obscureText: false,
      style: style,
      controller: ssid,
      readOnly: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Wifi SSID",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: password,
      readOnly: model.scanning,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final scanButton = ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () => model.scanDevice(password.text),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text("Connect device",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ));

    var form = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 45.0),
        ssidField,
        Text("Be sure to be connected to a 2.4ghz WiFi"),
        SizedBox(height: 25.0),
        passwordField,
        SizedBox(
          height: 35.0,
        ),
        Text(
            "Press and hold the connect button on the device for 3 seconds. When the light starts blinking, touch Connect device"),
        SizedBox(
          height: 35.0,
        ),
        model.scanning
            ? Center(child: CircularProgressIndicator())
            : scanButton,
        Text(model.scanError != null ? model.scanError.toString() : "")
      ],
    );

    var body = model.loading
        ? CircularProgressIndicator()
        : model.deviceIp != null
            ? Column(children: [
                Text("Found device at " + model.deviceIp + ". Configuring..."),
                SizedBox(height: 10.0),
                CircularProgressIndicator(),
              ])
            : form;

    return Center(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: body,
        ),
      ),
    );
  }

  @override
  String getTitle(AddDeviceModel model) {
    return 'Add Device';
  }

  @override
  void load() {
    Provider.of<AddDeviceModel>(this.context, listen: false)
        .checkConnectivity();
  }

  @override
  void dispose() {
    ssid.dispose();
    password.dispose();
    if (model != null) {
      model.cancel();
    }
    super.dispose();
  }
}
