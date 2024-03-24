import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rakashkh/auth/Splash_screen.dart';
import 'package:rakashkh/screen/BottomNavScreen.dart';
import 'package:rakashkh/widgets/base_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static SharedPreferences? pref;
  static String token = "";
  static String userNumber = "";
  static String userName = "";

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool login = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefrences();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: Container(
      color: Colors.blue,
    ));
  }

  Future<void> getPrefrences() async {
    IntroScreen.pref = await SharedPreferences.getInstance();
    login = GetIt.I.get<SharedPreferences>().getBool("loginOrSignup") ?? false;
    // login = IntroScreen.pref!.getBool("loginOrSignup") ?? false;
    if(kDebugMode)
      {
    print("login $login");

      }
    setState(() {});
    if(kDebugMode)
    {
      print("login $login");

    }
    if (login) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const BottomNavBar();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        ),
      );
    }
  }
}
