import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/1Demo/view_model/auth_view_model.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/auth/forgetpassword/onboard_content.dart';
import 'package:rakashkh/auth/intro_screen.dart';
import 'package:rakashkh/provider/authprovider.dart';
import 'package:rakashkh/screen/BottomNavScreen.dart';
import 'package:rakashkh/screen/HomeScreenMap.dart';
import 'package:rakashkh/widgets/base_scaffold.dart';
import 'package:rakashkh/widgets/button_widgets.dart';
import 'package:rakashkh/widgets/text_field_widget.dart';
import 'package:rakashkh/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenDemo extends StatefulWidget {
  const LoginScreenDemo({super.key});

  @override
  State<LoginScreenDemo> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenDemo> {
  final tcNumber = TextEditingController();
  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String fcmToken = "";
  String mPinValue = "";
  bool isLoading = false;
  late AuthenticationProvider authProvider;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // authProvider = context.read<AuthenticationProvider>();
  }

  @override
  Widget build(BuildContext context) {
  final   authViewMode = Provider.of<AuthViewModel>(context);

   // authProvider = context.watch<AuthenticationProvider>();
    return BaseScaffold(
      hasBack: false,
      hasAppbar: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.mainColor,
      child: Padding(
        padding: p20,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 130,
              ),
              _loginText(),
              const SizedBox(
                height: 70,
              ),
              _numberText(),
              h20,
              _numberTextField(),
              h30,
              _mPinText(),
              h20,
              _mPin(),
              h50,
          FilledButtons(
            isLoading: authViewMode.isLoding,
            color: const Color(0xff09A789),
            fontSize: 18,
            applyGradient: true,
            textColor: Palette.white,
            fontWeight: FontWeight.bold,
            height: 55,
            width: 271,
            onTap: () async {
              Map data = {
                // "number": tcNumber.text,
                //
                // "MPIN": mPinValue,
                // "fcm_token":fcmToken

                  // "email": "eve.holt@reqres.in",
                  // "password": "cityslicka"

                "number": "+919574337205",

                "MPIN": "1234",
                "fcm_token": "cGokXIcKQqav2jl0C3akZQ:APA91bFC_bgEv6HlYIoLCvq-8MzqLx0YOs5cbaVHmLjwqX-5Vod2M4CJJyHbeE_0in-8Lpnb-htwgZccOMJsoRd9FSfxRy-EW3KXHMDFwa_AcEbho4EI0DT7AkzJEaSkhgL3FzCfyopG"
              };
              await authViewMode.loginApi(data, context);

              // if (formKey.currentState!.validate()) {
              //   setState(() {
              //     isLoading = true;
              //   });
              //   // // GetFcmToken();
              //   // final token = IntroScreen.pref!.getString("token");
              //   final genrateToken = await FirebaseMessaging.instance.getToken();
              //
              //   // setState(() {
              //   //   if (token == genrateToken) {
              //   //     fcmToken = token!;
              //   //   } else {
              //   //     fcmToken = genrateToken!;
              //   //   }
              //   // });
              //
              //   authProvider
              //       .loginApi(
              //       tcNumber: tcNumber.text,
              //       mpinValue: mPinValue,
              //       fcmToken: fcmToken)
              //       .then((value) {
              //     if (value) {
              //       final contactNumber = authProvider.loginModel!.data!.user!.number;
              //       final userName = authProvider.loginModel!.data!.user!.name;
              //       IntroScreen.userNumber = contactNumber!;
              //       IntroScreen.userName = userName!;
              //       IntroScreen.token = authProvider.loginModel!.data!.token!;
              //       IntroScreen.pref!.setString("token", IntroScreen.token);
              //       IntroScreen.pref!.setString("UserNumber", IntroScreen.userNumber);
              //       // IntroScreen.pref!.setBool("loginOrSignup", true);
              //       GetIt.I.get<SharedPreferences>().setBool("loginOrSignup", true);
              //       GetIt.I.get<SharedPreferences>().setString("UserName", userName);
              //       GetIt.I.get<SharedPreferences>().setStringList("UserInfo", [userName,contactNumber]);
              //
              //       print("username ==> ${IntroScreen.userName}");
              //       print("userNumber ==> ${IntroScreen.userNumber}");
              //       // final number = IntroScreen.pref!.getString("UserNumber");
              //
              //       print(genrateToken);
              //       print(token);
              //
              //       if (genrateToken != token) {
              //         GetIt.I
              //             .get<SharedPreferences>()
              //             .setString("token", genrateToken!);
              //       } else {
              //         GetIt.I.get<SharedPreferences>().setString("token", token!);
              //       }
              //       setState(() {});
              //       Timer(const Duration(seconds: 2), () async {
              //         setState(() {
              //           isLoading = false;
              //         });
              //
              //         Navigator.pushReplacement(context, MaterialPageRoute(
              //           builder: (context) {
              //             return const BottomNavBar();
              //             // return mobileNumberScreen();
              //           },
              //         ));
              //       });
              //     } else {
              //       setState(() {
              //         isLoading = true;
              //       });
              //       print("invalid data");
              //     }
              //   });
              // }
            },
            text: 'LOGIN',
          ),
              const SizedBox(
                height: 90,
              ),
              _resetPin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginText() {
    return const Center(
      child: Texts(
        "LOGIN",
        fontSize: 50,
        fontFamily: "Gilroy",
        textAlign: TextAlign.center,
        color: Palette.white,
      ),
    );
  }

  Widget _numberText() {
    return const Center(
      child: Texts(
        "NUMBER",
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Palette.white,
      ),
    );
  }

  Widget _numberTextField() {
    return SizedBox(
      width: 330,
      child: TextFormFieldWidget(
        controller: tcNumber,
        filled: true,
        textAlign: TextAlign.center,
        filledColor: Colors.white38,
        textInputType: TextInputType.number,
        hintText: "Enter Your Number",
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 17),
        style: const TextStyle(color: Colors.black45, fontSize: 20),
        maxLength: 10,
        validator: (value) {
          if (value!.isEmpty) {
            return "ENTER A PHONE NUMBER";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _mPinText() {
    return const Center(
      child: Texts(
        "MPIN",
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Palette.white,
      ),
    );
  }

  Widget _mPin() {
    return Pinput(
      length: 4,
      forceErrorState: true,
      controller: pinController,
      obscureText: true,
      onCompleted: (value) {
        setState(() {
          mPinValue = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter a MPin";
        } else {
          return null;
        }
      },
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
            fontSize: 20, color: Colors.black45, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(color: Palette.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _loginButton(AuthViewModel authViewMode) {
    return FilledButtons(
      isLoading: authViewMode. isLoding,
      color: const Color(0xff09A789),
      fontSize: 18,
      applyGradient: true,
      textColor: Palette.white,
      fontWeight: FontWeight.bold,
      height: 55,
      width: 271,
      onTap: () async {
        Map data = {
          "number": tcNumber.text,

          "MPIN": mPinValue,
          "fcm_token":fcmToken
        };
      // await authViewMode.loginApi(data, context);


        // if (formKey.currentState!.validate()) {
        //   setState(() {
        //     isLoading = true;
        //   });
        //   // // GetFcmToken();
        //   // final token = IntroScreen.pref!.getString("token");
        //   final genrateToken = await FirebaseMessaging.instance.getToken();
        //
        //   // setState(() {
        //   //   if (token == genrateToken) {
        //   //     fcmToken = token!;
        //   //   } else {
        //   //     fcmToken = genrateToken!;
        //   //   }
        //   // });
        //
        //   authProvider
        //       .loginApi(
        //       tcNumber: tcNumber.text,
        //       mpinValue: mPinValue,
        //       fcmToken: fcmToken)
        //       .then((value) {
        //     if (value) {
        //       final contactNumber = authProvider.loginModel!.data!.user!.number;
        //       final userName = authProvider.loginModel!.data!.user!.name;
        //       IntroScreen.userNumber = contactNumber!;
        //       IntroScreen.userName = userName!;
        //       IntroScreen.token = authProvider.loginModel!.data!.token!;
        //       IntroScreen.pref!.setString("token", IntroScreen.token);
        //       IntroScreen.pref!.setString("UserNumber", IntroScreen.userNumber);
        //       // IntroScreen.pref!.setBool("loginOrSignup", true);
        //       GetIt.I.get<SharedPreferences>().setBool("loginOrSignup", true);
        //       GetIt.I.get<SharedPreferences>().setString("UserName", userName);
        //       GetIt.I.get<SharedPreferences>().setStringList("UserInfo", [userName,contactNumber]);
        //
        //       print("username ==> ${IntroScreen.userName}");
        //       print("userNumber ==> ${IntroScreen.userNumber}");
        //       // final number = IntroScreen.pref!.getString("UserNumber");
        //
        //       print(genrateToken);
        //       print(token);
        //
        //       if (genrateToken != token) {
        //         GetIt.I
        //             .get<SharedPreferences>()
        //             .setString("token", genrateToken!);
        //       } else {
        //         GetIt.I.get<SharedPreferences>().setString("token", token!);
        //       }
        //       setState(() {});
        //       Timer(const Duration(seconds: 2), () async {
        //         setState(() {
        //           isLoading = false;
        //         });
        //
        //         Navigator.pushReplacement(context, MaterialPageRoute(
        //           builder: (context) {
        //             return const BottomNavBar();
        //             // return mobileNumberScreen();
        //           },
        //         ));
        //       });
        //     } else {
        //       setState(() {
        //         isLoading = true;
        //       });
        //       print("invalid data");
        //     }
        //   });
        // }
      },
      text: 'LOGIN',
    );
  }

  Widget _resetPin() {
    return InkWell(
      onTap: () {
        Future.delayed(Duration.zero, () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(42),
                topRight: Radius.circular(42),
              ),
            ),
            builder: (_) => const OnboardContent(),
          );
        });
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return ForgetPassword();
        // },));
      },
      child: const Texts(
        "Reset MPIN",
        fontWeight: FontWeight.w300,
        fontSize: 19,
        textAlign: TextAlign.center,
        textDecoration: TextDecoration.underline,
        color: Palette.white,
      ),
    );
  }

// Future<void> GetFcmToken() async {
//   await FirebaseApi().initNotification().then((value) {
//     setState(() {
//       print(" value ${value}");
//       FcmToken = value;
//       print("fcm token ${FcmToken}");
//     });
//   });
// }
}
