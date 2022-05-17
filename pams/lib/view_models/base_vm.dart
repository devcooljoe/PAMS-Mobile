
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseViewModel extends ChangeNotifier {
  final Reader read;

  BaseViewModel(this.read);
  bool _busy = false;
  String _contentError = '';
  String _errorMessage = '';

  bool get busy => _busy;
  String get contentError => _contentError;
  String get errorMessage => _errorMessage;
  bool get hasErrorMessage => _errorMessage != '' && _errorMessage.isNotEmpty;

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setContentError(String message) {
    _contentError = message;
    notifyListeners();
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
