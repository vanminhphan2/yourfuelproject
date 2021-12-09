import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

late BuildContext _mainContext;

BuildContext get mainContext => _mainContext;

void setContext(BuildContext context) {
  _mainContext = context;
}

abstract class BaseProvider {
  T getProvider<T>() {
    return _mainContext.read<T>();
  }
}

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void show() {
    _isLoading = true;
    notifyListeners();
  }

  void hide() {
    _isLoading = false;
    notifyListeners();
  }
}
