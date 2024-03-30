import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rakashkh/model/UpdateMeModel.dart';

class UpdateMeProvider with ChangeNotifier {
  UpdateMeModel? updateMe;

  Future<bool> getUpdateMe(String name, String number) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZmViMjIyZDBkMGFiMWE0YTFhZDI4ZiIsImlhdCI6MTcxMTU1MjI1NiwiZXhwIjoxNzE5MzI4MjU2fQ.p-kxJmXDzTRzeJcgUs5QnQeeVUHEkoLQu7uA7q2HJRY'
    };
    var data = json.encode({
      "number": number,
      "name": name,
      "fcm_token":
          "cGokXIcKQqav2jl0C3akZQ:APA91bFC_bgEv6HlYIoLCvq-8MzqLx0YOs5cbaVHmLjwqX-5Vod2M4CJJyHbeE_0in-8Lpnb-htwgZccOMJsoRd9FSfxRy-EW3KXHMDFwa_AcEbho4EI0DT7AkzJEaSkhgL3FzCfyopG"
    });
    var dio = Dio();
    var response = await dio.request(
      'https://rakshak-backend-dev.onrender.com/api/v1/users/updateMe',
      options: Options(
        method: 'PATCH',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print("dio update me responsee");
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }

    return false;
  }
}
