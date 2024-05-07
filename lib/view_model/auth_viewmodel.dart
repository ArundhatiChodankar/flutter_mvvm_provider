import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_provider/repository/auth_repository.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final authRepository = AuthRepository();

  void loginApi(dynamic data, BuildContext context) {
    debugPrint("########### $data");
    setLoading(true);
    authRepository.loginApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage('Login Successful', context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}
