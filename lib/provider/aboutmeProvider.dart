
import 'package:flutter/foundation.dart';
import 'package:rakashkh/model/AboutMe.dart';
import 'package:http/http.dart' as http;

class AboutMeProvider with ChangeNotifier
{
  AboutMe? aboutMe;
  String? _name;
  String? _number;


  String? get name => _name;
  String? get number => _number;

  setName(String value)
  {
    _name = value;
  notifyListeners();
  }
  setNumber(String number)
  {
    _number= number;
    notifyListeners();
  }



  Future<bool> getAboutMe()  async {


    var header = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZmViMjIyZDBkMGFiMWE0YTFhZDI4ZiIsImlhdCI6MTcxMTI4NDIyNiwiZXhwIjoxNzE5MDYwMjI2fQ.jTbDpa76euiVqF1_3__iCzkmOUUx6lBrYmUl5-k5W18'
    };
    var url = Uri.parse("https://rakshak-backend-dev.onrender.com/api/v1/users/me");

    var response = await http.get(url,  headers: header);
    if (kDebugMode) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    if (response.statusCode == 400) {
      return false;
    } else {
      aboutMe = aboutMeFromJson(response.body);
      setName(aboutMe!.data.user.name);
      setNumber(aboutMe!.data.user.number);

      notifyListeners();
      return true;
    }
  }

}