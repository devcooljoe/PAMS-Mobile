import 'package:get_storage/get_storage.dart';
import 'package:pams/http/api_manager.dart';
import 'package:pams/models/login_response_model.dart';

class AuthServiceImplementation extends ApiManager {
  GetStorage box = GetStorage();

  final loginURl = '/Account/SignIn';

  //sign in user
  Future<LoginResponseModel> userLogin({required String? email, required String? password}) async {
    var body = {
      'email': email,
      'password': password,
    };

    final response = await postHttp(
      loginURl,
      body,
    );

    if (response.responseCodeError == null) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      return LoginResponseModel(status: false);
    }
  }
}
