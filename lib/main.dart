import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/utils/routes/routes.dart';
import 'package:flutter_mvvm_provider/utils/routes/routes_names.dart';
import 'package:flutter_mvvm_provider/view_model/auth_viewmodel.dart';
import 'package:flutter_mvvm_provider/view_model/home_view_model.dart';
import 'package:flutter_mvvm_provider/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var providers = [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => UserViewModel()),
      ChangeNotifierProvider(create: (_) => HomeViewModel())
    ];
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
        ),
        initialRoute: RouteNames.splash,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
