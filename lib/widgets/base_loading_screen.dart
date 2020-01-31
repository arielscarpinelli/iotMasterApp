import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gbridgeapp/models/base_loading_model.dart';
import 'package:gbridgeapp/models/device.dart';
import 'package:gbridgeapp/models/device_list_model.dart';
import 'package:provider/provider.dart';

import 'device_icon.dart';
import 'device_status_screen.dart';

abstract class BaseLoadingScreen<W extends StatefulWidget,
    T extends BaseLoadingModel> extends State<W> {
  @override
  Widget build(BuildContext context) {
    return Consumer<T>(builder: this._internalBuild);
  }

  Widget _internalBuild(BuildContext context, T model, Widget child) {
    return Scaffold(
      // Add from here...
      appBar: AppBar(
        title: Text(getTitle(model)),
      ),
      floatingActionButton: this.getFloatingActionButton(),
      body: model.loading
          ? Center(child: CircularProgressIndicator())
          : model.error != null ? renderError(model) : render(model),
    );
  }

  Widget render(T model);

  String getTitle(T model);

  void load();

  @override
  void initState() {
    super.initState();
    load();
  }

  Widget renderError(T model) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(model.error.toString()),
        MaterialButton(
          onPressed: () => load(),
          child: Text(
            "Retry",
            textAlign: TextAlign.center,
          ),
        )
      ],
    ));
  }

  Widget getFloatingActionButton() {
    return null;
  }
}
