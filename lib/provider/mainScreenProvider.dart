import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rakashkh/model/nearest_location_data_model.dart';

class MainScreenProvider extends ChangeNotifier {
  var hospitalDataList = [];
  var fireList = [];
  var policeList = [];

  //DEPARTMENT LOcation
  var firedepartmentLocationList = [];
  var policedepartmentLocationList = [];
  var hospitaldepartmentLocationList = [];

  int _fire = 0;
  int _hospital = 0;
  int _police = 0;


  int get fire => _fire;
  int get hospital => _hospital;
  int get police => _police;

  setFire(int value) {
    _fire = value;
    notifyListeners();
  }

  setHospital(int value) {
    _hospital = value;
    notifyListeners();
  }


  setPolice(int value) {
    _police = value;
    notifyListeners();
  }

  List<dynamic> policeList1 = [];
  List<dynamic> fireList1 = [];
  List<dynamic> hospitalList1 = [];
  NearestLocationDataModel? nearestLocationDataModel;

  Future<void> getNearestLoaction(
      {required double latitude, required double longitude}) async {

    var url = Uri.parse(

        "https://rakshak-backend-dev.onrender.com/api/v1/organization/nearest-organization/$latitude,$longitude");
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('get nearest location: ${response.body}');
    nearestLocationDataModel =
        NearestLocationDataModel.fromJson(jsonDecode(response.body));
    if (nearestLocationDataModel != null) {
      for (var x in nearestLocationDataModel!.data!.department!) {
        if (x.type!.toLowerCase() == "hospital") {
          print(" hospital >>>>>${x.departments.runtimeType}");
          for (final dep in x.departments!) {
            hospitalDataList.add(dep);
          }
        }
        if (x.type!.toLowerCase() == "fire") {
          print(" fire >>>>>${x.departments.runtimeType}");
          for (final dep in x.departments!) {
            fireList.add(dep);
          }
        }
        if (x.type!.toLowerCase() == "police") {
          print("police >>>>>${x.departments.runtimeType}");
          for (final dep in x.departments!) {
            policeList.add(dep);
          }
        }
      }
      for (var x in nearestLocationDataModel!.data!.departmentLocation!) {

     if(x.type=="Fire" ){
       // print(" fire values ${x.}");
       firedepartmentLocationList.add(x);
       notifyListeners();

     }
     if(x.type=="Hospital"){
       hospitaldepartmentLocationList.add(x);

     }
     if(x.type=="Police"){
       policedepartmentLocationList.add(x);
     }
      }
    }

    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> departments = jsonResponse['data']['department'];


    for (var department in departments) {
      String departmentType = department['_id'];

      if (departmentType == 'Police') {
        policeList1.addAll(department['departments']);
        notifyListeners();
      } else if (departmentType == 'Fire') {
        fireList1.addAll(department['departments']);
        notifyListeners();

      } else if (departmentType == 'Hospital') {
        hospitalList1.addAll(department['departments']);
        notifyListeners();

      }
    }

    // Printing the filtered lists
    print('Police Stations:');
    print(policeList1[0]);
    print(policeList1[1]);
    print(policeList1[2]);

    print('\nFire Stations:');
    print(fireList1);

    print('\nHospitals:');
    print(hospitalList1);
    notifyListeners();


  }


}
