import 'package:avgleclient/data/app_error.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final errorNotifierProvider = ChangeNotifierProvider((ref) => ErrorNotifier());

class ErrorNotifier extends ChangeNotifier {
  AppError _error;

  bool _hasBeenHandled = true;

  bool get hasBeenHandled => _hasBeenHandled;

  void doOnError(AppError appError) {
    _error = appError;
    _hasBeenHandled = false;
    notifyListeners();
  }

  void doOnSuccess() {
    _error = null;
    _hasBeenHandled = true;
  }

  AppError getErrorIfNotHandled() {
    if (_hasBeenHandled) {
      _error = null;
      return _error;
    } else {
      _hasBeenHandled = true;
      return _error;
    }
  }

  AppError peekContent() => _error;
}
