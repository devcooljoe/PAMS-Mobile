import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/models/future_manager.dart';
import 'package:pams/models/login_response_model.dart';
import 'package:pams/providers/auth_provider.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/view_models/base_vm.dart';

class AuthViewModel extends BaseViewModel {
  final Reader reader;

  FutureManager<LoginResponseModel> userData = FutureManager();

  AuthViewModel(this.reader) : super(reader);

  userLoginService({required String email, required String password}) async {
    userData.load();
    notifyListeners();
    final res = await reader(authServiceProvider)
        .userLogin(email: email, password: password);
    if (res.status == true) {
      userData.onSuccess(res);

      notifyListeners();
    } else {
      userData.onError('Error');
      notifyListeners();
    }
  }
}
