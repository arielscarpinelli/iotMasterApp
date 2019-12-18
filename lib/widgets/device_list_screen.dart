import 'package:flutter/material.dart';
import 'package:gbridgeapp/models/device.dart';
import 'package:gbridgeapp/models/device_list_model.dart';
import 'package:provider/provider.dart';

class DeviceListScreen extends StatefulWidget {

  @override
  _DeviceListScreen createState() => _DeviceListScreen();
}

class _DeviceListScreen extends State<DeviceListScreen> {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceListModel>(builder: this.doBuild);
  }

  Widget doBuild(BuildContext context, DeviceListModel model, Widget child) {
    return Scaffold (                   // Add from here...
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(model),
    );
  }

  Widget _buildSuggestions(DeviceListModel model) {
    return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: model.data?.length ?? 0,
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(model.data[i]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
    );
  }

  Widget _buildRow(Device device) {
    return ListTile(
      title: Text(
        device.name,
        style: _biggerFont,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DeviceListModel>(this.context, listen: false).fetchDevices();
  }

}
