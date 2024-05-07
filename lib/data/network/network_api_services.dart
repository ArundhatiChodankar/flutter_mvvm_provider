import 'dart:convert';
import 'dart:io';

import '../app_exceptions.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
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
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      jsonResponse = returnJsonResponse(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }
    return jsonResponse;
  }
}

dynamic returnJsonResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    case 400:
      dynamic errorResponse = jsonDecode(response.body);
      throw BadRequestException(errorResponse['error'].toString());
    default:
      throw InternetException(
          "${response.statusCode} : ${response.reasonPhrase}");
  }
}
