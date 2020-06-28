import 'package:flutter/material.dart';
import 'package:iotmasterapp/models/device.dart';
import 'package:iotmasterapp/models/device_list_model.dart';
import 'package:provider/provider.dart';

import 'add_device_screen.dart';
import 'base_loading_screen.dart';
import 'device_icon.dart';
import 'device_status_screen.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreen createState() => _DeviceListScreen();
}

class _DeviceListScreen
    extends BaseLoadingScreen<DeviceListScreen, DeviceListModel> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  String getTitle(DeviceListModel model) {
    return 'Devices';
  }

  @override
  void load() {
    Provider.of<DeviceListModel>(this.context, listen: false).fetchDevices();
  }

  @override
  Widget render(DeviceListModel model) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: model.data?.length ?? 0,
      itemBuilder: (BuildContext _context, int i) {
        return _buildRow(model.data[i]);
      },
    );
  }

  Widget _buildRow(Device device) {
    return Card(
        child: InkWell(
      onTap: () => this.onTap(device),
      child: ListTile(
        leading: DeviceIcon(device.type),
        title: Text(device.name, style: _biggerFont),
        subtitle: Text(device.friendlyType),
      ),
    ));
  }

  onTap(Device device) {
    return Navigator.push(context,
        new MaterialPageRoute(builder: (ctx) => DeviceStatusScreen(device.deviceid)));
  }

  onAddNew() {
    return Navigator.push(
        context, new MaterialPageRoute(builder: (ctx) => AddDeviceScreen()));
  }

  @override
  Widget getFloatingActionButton() {
    return FloatingActionButton(
        child: Icon(Icons.add), onPressed: () => this.onAddNew());
  }
}
