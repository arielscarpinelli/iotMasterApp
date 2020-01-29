import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gbridgeapp/models/device.dart';
import 'package:gbridgeapp/models/device_detail_model.dart';
import 'package:gbridgeapp/models/device_list_model.dart';
import 'package:provider/provider.dart';

import 'base_loading_screen.dart';
import 'device_icon.dart';

class DeviceStatusScreen extends StatefulWidget {
  DeviceStatusScreen(this.device);

  final Device device;

  @override
  _DeviceStatusScreen createState() => _DeviceStatusScreen();
}

class _DeviceStatusScreen extends BaseLoadingScreen<DeviceStatusScreen, DeviceDetailModel> {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget render(DeviceDetailModel model) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: (model.data?.traits?.length ?? 0) + 1,
      itemBuilder: (BuildContext _context, int i) {
        return i == 0
            ? _buildHeader(model.data)
            : _buildRow(model.data.traits[i - 1]);
      },
    );
  }

  Widget _buildRow(TraitType trait) {
    return Card(
        child: InkWell(
      child: ListTile(
        title: Text(trait.type),
        subtitle: trait.lastStatus != null ? Text(trait.lastStatus) : null,
      ),
    ));
  }

  Widget _buildHeader(Device device) {
    return Card(
        child: InkWell(
      child: ListTile(
        leading: DeviceIcon(device.type),
        title: Text(device.name, style: _biggerFont),
        subtitle: device.type != null ? Text(describeEnum(device.type)) : null,
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  String getTitle(DeviceDetailModel model) {
    return model.data != null ? model.data.name : widget.device.name;
  }

  @override
  void load() {
    Provider.of<DeviceDetailModel>(this.context, listen: false)
        .fetchDevice(widget.device.id);
  }
}
