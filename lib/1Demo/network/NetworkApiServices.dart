import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rakashkh/1Demo/app_excaption.dart';
import 'package:rakashkh/1Demo/network/BaseApiServices.dart';


class NetworkApiServices extends BaseApiServices {
  var header = {
    'Content-type': 'application/json',
    // 'Accept': 'application/json',
  };
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url,dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await http.post(Uri.parse(url),body: jsonEncode(data),  headers: header);
      print(response.body);
      print(response.statusCode);

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response)
  {
    switch(response.statusCode)
        {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      // case 400:
      //   print("400 ");
      //   throw BadRequestException(response.body.toString());
      // case 404:
      //   print("4004");
      //
      //   throw UnauthorisedException(response.body.toString());
      default:
        print("40012");

        throw FetchDataException("Error accorded while communicating with server with status code ${response.statusCode}");
    }
  }
}
