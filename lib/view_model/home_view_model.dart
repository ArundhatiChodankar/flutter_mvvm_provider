import 'package:flutter/material.dart';
import '../data/response/api_response.dart';
import '../models/products_model.dart';
import '../repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepository = HomeRepository();

  ApiResponse<List<ProductModel>> productsList = ApiResponse.loading();

  setProductsList(ApiResponse<List<ProductModel>> response) {
    productsList = response;
    notifyListeners();
  }

  void fetchProductsListApi() async {
    setProductsList(ApiResponse.loading());
    _homeRepository.fetchProductsList().then((data) {
      debugPrint("before completed im here!");
      setProductsList(ApiResponse.completed(data));
    }).onError((error, stackTrace) {
      setProductsList(ApiResponse.error(error.toString()));
    });
  }
}
