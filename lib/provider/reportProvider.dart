import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rakashkh/model/Oprationreport.dart';

class ReportProvider extends ChangeNotifier {

  var dio = Dio();
  // OperationReport? operationReport;

List<double> _location = [];




  List<double> get location => _location;



  setLatlong(double latitude, double longitude )
  {
    _location = [longitude,latitude];
    notifyListeners();
  }

  Future<bool> ReportDioApi(
    File selectedImag,
    List<double> location,
    String usernumber,
    List<String> departmentSid,
    String description,


  ) async {
    print(usernumber);
    String description1 = description;
    String usernumber1 = "+91$usernumber";
    String departments = concatenateList(departmentSid);
    Map<String, dynamic> jsonData = {
      "location": {
        "type": "Point",
        "coordinates": _location
        // "coordinates": [72.90135322499116, 21.25141024985171]
      },
      "description": description1,
      "number": "$usernumber1",
      "department": departments
    };
    String perfectJson = jsonEncode(jsonData);

    var request = http.MultipartRequest('POST',
        Uri.parse('https://rakshak-backend-dev.onrender.com/api/v1/operation'));
    request.fields.addAll({
      'data': perfectJson,
    });
    request.files
        .add(await http.MultipartFile.fromPath('file', selectedImag.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(await response.stream.bytesToString());

      notifyListeners();

      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  String concatenateList(List<String> inputList) {
    return inputList.join('::');
  }


}
