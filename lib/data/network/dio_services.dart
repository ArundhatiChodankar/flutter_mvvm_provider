import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mvvm_provider/res/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioService{

  DioService()  {

    final options = BaseOptions(
      baseUrl: AppUrls.baseUrl,
      headers: {
        HttpHeaders.authorizationHeader:'Bearer ${getToken()}'
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    _dio = Dio(options);
  }
  
  late Dio _dio;
  Dio get dio =>_dio;

  Future<String?> getToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString("token");
    return token;
  }
}