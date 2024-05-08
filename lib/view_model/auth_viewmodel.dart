import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_provider/repository/auth_repository.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  final authRepository = AuthRepository();

  void loginApi(dynamic data, BuildContext context) {
    setLoading(true);
    authRepository.loginApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Login Successful', context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  void signUpApi(dynamic data, BuildContext context) {
    debugPrint("########### $data");
    setSignUpLoading(true);
    authRepository.signUpApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage('SignUp Successful', context);
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}
