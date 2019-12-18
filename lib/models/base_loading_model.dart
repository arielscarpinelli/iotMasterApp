import 'package:flutter/foundation.dart';

class BaseLoadingModel<T> extends ChangeNotifier {

  T _data;
  String _lastError;
  bool _loading = false;

  bool get loading => _loading;
  String get lastError => _lastError;
  get data => _data;

  fetch(Future<T> toAwait) async {
    this._lastError = null;
    this._loading = true;
    this._data = null;
    notifyListeners();
    try {
      this._data = await toAwait;
    } catch (e) {
      this._lastError = e.toString();
    } finally {
      this._loading = false;
      notifyListeners();
    }
  }


}