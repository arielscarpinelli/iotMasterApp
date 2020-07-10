import 'package:flutter/material.dart';
import 'package:iotmasterapp/models/base_loading_model.dart';
import 'package:provider/provider.dart';

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
        actions: getAppBarActions(model),
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
    renderAnError(model.error.toString(), () => load());
    return render(null);
  }

  void renderAnError(String message, void Function() retry) {
    final snackBar = SnackBar(
        content: Text(message),
        action: retry != null
            ? SnackBarAction(label: 'Retry', onPressed: retry)
            : null);
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget getFloatingActionButton() {
    return null;
  }

  List<Widget> getAppBarActions(T model) {
    return null;
  }
}
