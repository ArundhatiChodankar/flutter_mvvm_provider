import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/app_strings.dart';
import '../res/widgets/round_button.dart';
import '../res/widgets/spacing.dart';
import '../utils/routes/routes_names.dart';
import '../utils/utils.dart';
import '../view_model/auth_viewmodel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final ValueNotifier<bool> _obsecureNotifier = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.signup),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (value) {
                Utils.changeNodeFocus(context,
                    current: _emailFocus, next: _passwordFocus);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                label: const Text(AppStrings.email),
                hintText: "abc@gmail.com",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const VerticalSpace(25),
            ValueListenableBuilder(
              valueListenable: _obsecureNotifier,
              builder: (BuildContext context, bool value, Widget? child) {
                return TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: _obsecureNotifier.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: _obsecureNotifier.value
                        ? InkWell(
                      onTap: () {
                        _obsecureNotifier.value = !_obsecureNotifier.value;
                      },
                      child: const Icon(Icons.visibility),
                    )
                        : InkWell(
                      onTap: () {
                        _obsecureNotifier.value = !_obsecureNotifier.value;
                      },
                      child: const Icon(Icons.visibility_off),
                    ),
                    label: const Text(AppStrings.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
            const VerticalSpace(50),
            RoundButton(
                title: AppStrings.signup,
                loading: authViewModel.signUpLoading,
                onPress: () {
                  if (_emailController.text.isEmpty &&
                      _passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        AppStrings.emailPasswordEmptyError, context);
                  } else if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage(AppStrings.emailEmptyError, context);
                  }  else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(AppStrings.passwordEmptyError, context);
                  } else if (_passwordController.text.length<6) {
                    Utils.flushBarErrorMessage(AppStrings.passwordLengthError, context);
                  } else {
                    Map data = {
                      'email':_emailController.text.toString(),
                      'password':_passwordController.text.toString()
                    };

                    authViewModel.signUpApi(data, context);
                  }
                }),
            const VerticalSpace(50),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.login);
                },
                child: Text(AppStrings.loginLink))
          ],
        ),
      ),
    );
  }
}
