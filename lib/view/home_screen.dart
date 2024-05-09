import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../utils/routes/routes_names.dart';
import '../view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel hm = HomeViewModel();
  @override
  void initState() {
    super.initState();
    hm.fetchProductsListApi();
  }
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
      body : ChangeNotifierProvider<HomeViewModel>(
    create: (context) => hm,
    child:Consumer<HomeViewModel>(
          builder: (context, value, child) {
          switch (value.productsList.status) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              case Status.error:
                return Center(
                  child: Text(
                    value.productsList.message.toString(),
                  ),
                );
              case Status.completed:
                return ListView.builder(
                    itemCount: value.productsList.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(value.productsList.data![index].title
                              .toString()),
                          subtitle: Text(value
                              .productsList.data![index].category
                              .toString()),
                          leading: Image.network(
                            value.productsList.data![index].image
                                .toString(),
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.error,
                                color: Colors.red,
                              );
                            },
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          trailing:
                              Text(
                                value
                                    .productsList.data![index].price.toString())
                              ,

                        ),
                      );
                    });

              default:
                return Container();
            }
          },
      ),
      ),
    );
  }
}
