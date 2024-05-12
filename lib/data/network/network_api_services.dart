import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mvvm_provider/data/network/dio_services.dart';

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {

  final _dio = DioService().dio;

  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await _dio.get(url);
      jsonResponse = returnJsonResponse(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }
    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic jsonResponse;
    try {
      final response = await _dio
          .post(url, data: data);
      jsonResponse = returnJsonResponse(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }
    return jsonResponse;
  }
}

dynamic returnJsonResponse(Response<dynamic> response) {
  switch (response.statusCode) {
    case 200:
      return response.data;
    case 400:
      dynamic errorResponse = jsonDecode(response.data);
      throw BadRequestException(errorResponse['error'].toString());
    default:
      throw InternetException(
          "${response.statusCode} : ${response.statusMessage}");
  }
}
