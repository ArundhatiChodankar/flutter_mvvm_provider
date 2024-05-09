import 'package:flutter/cupertino.dart';
import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/products_model.dart';
import '../res/app_urls.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<List<ProductModel>> fetchProductsList() async {
    try {
      debugPrint("first line fetchProductsList function");
      List response =
          await _apiServices.getGetApiResponse(AppUrls.productsUrl);
       return response.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
