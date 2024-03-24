import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/1Demo/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:rakashkh/screen/BottomNavScreen.dart';
import 'package:rakashkh/screen/HomeScreenMap.dart';
import 'package:rakashkh/screen/googlemapscreen.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _isLoding = false;

  bool get isLoding => _isLoding;

  setisLoding(bool value) {
    _isLoding = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setisLoding(true);
    await _myRepo.loginAPi(data).then((value) {
      setisLoding(false);
      print("value ==> $value");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return BottomNavBar();
      }));
    }).onError((error, stackTrace) {
      setisLoding(false);

      print("error ==> ${error.toString()}");
    });
    // setisLoding(true);
    // final userPrefrence = Provider.of<UserViewModel>(context,listen:false);
    // _myRepo.loginAPi(data).then((value) {
    //   userPrefrence.saveUser(value);
    //   // Utils().flushBarErrorMessage("login Successfully", context);
    //   setisLoding(false);
    //   // Navigator.pushNamed(context, RoutesName.home);
    //
    //   if (kDebugMode) {
    //     print(value.toString());
    //   }
    // }).onError((error, stackTrace) {
    //   setisLoding(false);
    //
    //   Utils().toastMessage(error.toString());
    // });
  }
}
