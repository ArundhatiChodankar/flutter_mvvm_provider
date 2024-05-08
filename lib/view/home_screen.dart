import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_names.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final preferences = Provider.of<UserViewModel>(context);
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              preferences.removeUser().then((value) {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteNames.login);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Ink(
                child: const Text("Logout"),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
