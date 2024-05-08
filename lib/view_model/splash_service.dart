import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/view_model/user_view_model.dart';

import '../utils/routes/routes_names.dart';

class SplashService {
  static void checkAuthentication(BuildContext context) async {
    final userViewModel = UserViewModel();

    final user = await userViewModel.getUser();

    if (user!.token.toString() == "null" || user.token.toString() == "") {
      await Future.delayed(const Duration(seconds: 3));
      if (!context.mounted) return;
      Navigator.pushNamed(context, RouteNames.login);
    } else {
      await Future.delayed(const Duration(seconds: 3));
      if (!context.mounted) return;
      Navigator.pushNamed(context, RouteNames.home);
    }
  }
}
