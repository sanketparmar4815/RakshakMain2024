
import 'package:rakashkh/1Demo/app_url.dart';
import 'package:rakashkh/1Demo/network/BaseApiServices.dart';
import 'package:rakashkh/1Demo/network/NetworkApiServices.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginAPi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
