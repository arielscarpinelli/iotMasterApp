import 'package:flutter/foundation.dart';

class BaseLoadingModel<T> extends ChangeNotifier {

  T _data;
  String _lastError;
  bool _loading = false;

  bool get loading => _loading;
  String get error => _lastError;
  T get data => _data;
  @protected
  set data(T d) => _data = d;

  fetch(Future<T> toAwait) async {
    this._lastError = null;
    this._loading = true;
    data = null;
    notifyListeners();
    try {
      data = await toAwait;
    } catch (e) {
      this._lastError = e.toString();
    } finally {
      this._loading = false;
      notifyListeners();
    }
  }

}