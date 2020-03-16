import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/device_detail_model.dart';
import 'models/device_list_model.dart';
import 'models/login_model.dart';
import 'models/add_device_model.dart';
import 'widgets/login_screen.dart';
import 'widgets/device_list_screen.dart';
import 'service/iotmaster_api.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            builder: (context) => LoginModel(IotMasterApi())),
        ChangeNotifierProvider(
            builder: (context) => DeviceListModel(IotMasterApi(), context)),
        ChangeNotifierProvider(
            builder: (context) => DeviceDetailModel(IotMasterApi(), context)),
        ChangeNotifierProvider(
            builder: (context) => AddDeviceModel()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gBridge',
      home: Consumer<LoginModel>(
          builder: (ctx, model, child) =>
              !model.loggedIn ? LoginScreen() : DeviceListScreen()),
    );
  }
}
