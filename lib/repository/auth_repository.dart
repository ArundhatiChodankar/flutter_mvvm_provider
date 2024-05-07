import 'package:flutter_mvvm_provider/data/network/base_api_services.dart';

import '../data/network/network_api_services.dart';
import '../res/app_urls.dart';

class AuthRepository {
  final BaseApiServices _network = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      final response = await _network.getPostApiResponse(AppUrls.loginEndPoint, data);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }


  Future<dynamic> signUpApi(dynamic data) async {
    try {
      final response =
      await _network.getPostApiResponse(AppUrls.registerEndPoint, data);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }

}