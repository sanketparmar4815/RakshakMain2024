import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/globals.dart';
import 'package:rakashkh/custom_widget/homaecard.dart';
import 'package:rakashkh/model/nearest_location_data_model.dart';
import 'package:rakashkh/provider/authprovider.dart';
import 'package:rakashkh/provider/mainScreenProvider.dart';
import 'package:rakashkh/screen/Cart_services.dart';
import 'package:rakashkh/screen/Settings_With_Destination.dart';
import 'package:rakashkh/widgets/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreenMap extends StatefulWidget {
  const HomeScreenMap({super.key});

  @override
  State<HomeScreenMap> createState() => _HomeScreenMapState();
}

class _HomeScreenMapState extends State<HomeScreenMap> {
   MainScreenProvider? mainProvider;

  double latitude = 21.2266;
  double longitude = 72.8312;


  final List<Marker> _markers = <Marker>[];

  final Completer<GoogleMapController> _controller = Completer();
      CameraPosition cameraPosition = CameraPosition(
    target: LatLng(20.42796133580664, 75.885749655962),
    zoom: 14.4746,
  );

  late Uint8List fireMarker;
  late Uint8List policeMarker;
  late Uint8List hospitalMarker;
  late Uint8List currentUserMarker;

  String role = "";

  bool cardShow = false;

  late NearestLocationDataModel nearestLocationDataModel;
  DepartmentLocation? model;
  late AuthenticationProvider authProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
          Permission.camera,
      ].request();
      await Geolocator.requestPermission()
      // ;
          .then((value) async {
        final position = await Geolocator.getCurrentPosition();
        latitude = position.latitude;
        longitude = position.longitude;
         cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14,
        );
      })
          .onError((error, stackTrace) async {
        await Geolocator.requestPermission();
      });
      // await getCurrentLocation();
      // final position = await Geolocator.getCurrentPosition();
      // latitude = position.latitude;
      // longitude = position.longitude;
      // CameraPosition cameraPosition = CameraPosition(
      //   target: LatLng(position.latitude, position.longitude),
      //   zoom: 14,
      // );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );



      mainProvider!
          .getNearestLoaction(latitude: latitude, longitude: longitude)
          .then((value) {
        _initializeMap();
      });

      // var url = Uri.parse("https://rakshak-backend-dev.onrender.com/api/v1/organization/nearest-organization/$latitude,$longitude");
      // var response = await http.get(url);
      // print('Response status: ${response.statusCode}');
      // print('get nearest location: ${response.body}');

      setState(() {});

    });

    // getprefrences();
    // _getPermission();
    authProvider = context.read<AuthenticationProvider>();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Palette.mainColor, // navigation bar color
      statusBarColor: Palette.mainColor, // status bar color
    ));
    mainProvider = context.read<MainScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    mainProvider = context.watch<MainScreenProvider>();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Palette.appbar,
          ),
          drawer: const SettingWithDestinationScreen(),
          // (authProvider.signUpModel!.data!.newUser!.role! == "User" ||
          //     authProvider.loginModel!.data!.user!.role == "User") ? SettingWithDestinationScreen() :SettingWithAdmin(),

          body: Stack(
            children: [
              _googleMap(),
              _scrollDown(),
              _cardForMarker(),
            ],
          )),
    );
  }

  Widget _cardForMarker() {
    return cardShow
        ? Positioned(
            top: 400,
            left: 50,
            child: Stack(
              children: [
                model != null
                    ? HomeCard(
                  address: model!.address,
                  phoneNumber: "902308081031",
                  color: model!.type == "Fire"
                      ? Palette.redLight
                      : model!.type == "Hospital"
                      ? Palette.card_blue
                      : Palette.yellow,
                  stationTitle: model!.slug,
                  stationName: model!.type,
                  svg: model!.type == "Fire"
                      ? "assets/fire.svg"
                      : model!.type == "Hospital"
                      ? "assets/heart-pulse.svg"
                      : "assets/Police.svg",
                  onTap: () {},
                )


                    : const SizedBox(),
                Positioned(
                  top: 5,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          cardShow = false;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 25,
                      )),
                )
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _scrollDown() {
    return Positioned(
      bottom: 80,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            SizedBox(width: screenWidth * .30),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 400),
                          child: CartServices(
                            isColor: true,
                          )));
                },
                child: const RoundButton(
                    buttonname: "SCROLL DOWN", icon: Icons.arrow_drop_down),
              ),
            ),
            SizedBox(width: screenWidth * .15),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 40),
            //   child: CircleAvatar(
            //       backgroundColor: Colors.white,
            //       child: IconButton(
            //           onPressed: () {},
            //           icon: const Icon(
            //             Icons.layers,
            //             color: Colors.black,
            //           ))),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _googleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,

      onMapCreated: (controller) {
        _controller.complete(controller);

        setState(() {});
      },
      myLocationEnabled: true,
      compassEnabled: true,
      initialCameraPosition: cameraPosition,
      markers: Set<Marker>.of(_markers),
      // Marker(
      //   markerId: const MarkerId("current Location"),
      //   position: LatLng(latitude, longitude),
      // )
    );
  }

  Future<void> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    final position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    setState(() {});

    mainProvider!
        .getNearestLoaction(latitude: latitude, longitude: longitude)
        .then((value) {
      _initializeMap();
    });
  }

  // Future<void> _getPermission() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.location,
  //     Permission.camera,
  //   ].request();
  //     getUserCurrentLocation();
  // }

  Future<void> _initializeMap() async {
    fireMarker = await getBytesFromAsset("assets/fire.png", 100);
    currentUserMarker = await getBytesFromAsset("assets/user.png", 60);
    createMarker(
      latitude: latitude,
      longitude: longitude,
      icon: currentUserMarker,
      onTap: () {
        setState(() {
          cardShow = true;
        });
      },
    );


    for (var e in mainProvider!.fireList1) {
      fireMarker = await getBytesFromAsset("assets/fire.png", 100);
      createMarker(
        latitude: e["location"]["coordinates"][1],
        longitude: e["location"]["coordinates"][0],
        icon: fireMarker,
        onTap: () {

          setState(() {
            model = DepartmentLocation.fromJson(e.toJson());
            cardShow = true;
          });
        },
      );
    }
    for (var e in mainProvider!.hospitalList1) {
      hospitalMarker = await getBytesFromAsset("assets/hospital.png", 100);
      createMarker(
        latitude: e["location"]["coordinates"][1],
        longitude: e["location"]["coordinates"][0],
        icon: hospitalMarker,
        onTap: () {

          setState(() {
            model = DepartmentLocation.fromJson(e.toJson());
            cardShow = true;
          });
        },
      );
    }
    for (var e in mainProvider!.policeList1) {
      policeMarker = await getBytesFromAsset("assets/Police.png", 100);
      createMarker(
        latitude: e["location"]["coordinates"][1],
        longitude: e["location"]["coordinates"][0],
        icon: policeMarker,
        onTap: () {

          setState(() {
            model = DepartmentLocation.fromJson(e.toJson());
            cardShow = true;
          });
        },
      );
    }
    // for (var e in mainProvider!.firedepartmentLocationList) {
    //   fireMarker = await getBytesFromAsset("assets/fire.png", 100);
    //   createMarker(
    //     latitude: e.location.coordinates[1],
    //     longitude: e.location.coordinates[0],
    //     icon: fireMarker,
    //     onTap: () {
    //
    //       setState(() {
    //         model = DepartmentLocation.fromJson(e.toJson());
    //         cardShow = true;
    //       });
    //     },
    //   );
    // }
    // for (var e in mainProvider!.hospitaldepartmentLocationList) {
    //   hospitalMarker = await getBytesFromAsset("assets/hospital.png", 100);
    //   createMarker(
    //     latitude: e.location.coordinates[1],
    //     longitude: e.location.coordinates[0],
    //     icon: hospitalMarker,
    //     onTap: () {
    //       setState(() {
    //         model = DepartmentLocation.fromJson(e.toJson());
    //         cardShow = true;
    //       });
    //     },
    //   );
    // }
    // for (var e in mainProvider!.policedepartmentLocationList) {
    //   policeMarker = await getBytesFromAsset("assets/Police.png", 100);
    //   createMarker(
    //     latitude: e.location.coordinates[1],
    //     longitude: e.location.coordinates[0],
    //     icon: policeMarker,
    //     onTap: () {
    //       setState(() {
    //         model = DepartmentLocation.fromJson(e.toJson());
    //         cardShow = true;
    //       });
    //     },
    //   );
    // }
    setState(() {});
  }

  Future<void> createMarker(
      {required double latitude,
      required double longitude,
      required Uint8List icon,
      void Function()? onTap}) async {
    _markers.add(
      Marker(
        onTap: onTap,
        markerId: MarkerId(UniqueKey().toString()),
        icon: BitmapDescriptor.fromBytes(icon),
        position: LatLng(latitude, longitude),
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void getprefrences() {
    setState(() {
      // role = GetIt.I.get<SharedPreferences>().getString("role")!;
      // role = IntroScreen.pref!.getString("role") ?? "";
      // final token = IntroScreen.pref!.getString("token") ?? "";
      // final token = GetIt.I.get<SharedPreferences>().getString("token")!;
      // print("home screen token token $token");
    });
  }


   // Future<void> getCurrentLocation()
   // async {
   //   final position = await Geolocator.getCurrentPosition();
   //   setState(()  {
   //     latitude = position.latitude;
   //     longitude = position.longitude;
   //     CameraPosition cameraPosition = CameraPosition(
   //       target: LatLng(position.latitude, position.longitude),
   //       zoom: 14,
   //     );
   //
   //   });
   //   final GoogleMapController controller = await _controller.future;
   //   controller.animateCamera(
   //     CameraUpdate.newCameraPosition(cameraPosition),
   //   );
   //   print(latitude);
   // }
}
