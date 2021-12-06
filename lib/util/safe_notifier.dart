import 'package:flutter/material.dart';

/// Exposes a notify() method which is a safer version of notifyListeners().
/// Before notifying listeners, it first checks that this ChangeNotifier has not already been disposed.
/// This avoids a common exception thrown when calling notifyListeners();
mixin SafeNotifierMixin on ChangeNotifier {
  bool _mounted = true;

  void notify() {
    if (_mounted) notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
