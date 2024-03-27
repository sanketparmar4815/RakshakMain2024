import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/custom_widget/cards.dart';
import 'package:rakashkh/provider/mainScreenProvider.dart';
import 'package:rakashkh/provider/reportProvider.dart';
import 'package:rakashkh/screen/BottomNavScreen.dart';
import 'package:rakashkh/utils/toastMassage.dart';
import 'package:rakashkh/videoscreen.dart';
import 'package:rakashkh/widgets/card_title.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController describeController = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  String selectedDesignation = 'Current Location';
  List<String> designation = [
    "Current Location",
    "Home Location",
    "Office Address"
  ];

  List<File> selectedImages = [];
  final ImagePicker picker = ImagePicker();

  File? imageFile;

  // bool isVideo = false;

  // late PageController _pageController;
  // late MainScreenProvider mainprovider;
  late ReportProvider reportProvider;

  // Departments? fireModel;
  // Departments? policeModel;
  // Departments? hospitalModel;

  // List<Departments> fireModelList = [];
  // List<Departments> policeModelList = [];
  // List<Departments> hospitalModelList = [];

  // String? token = IntroScreen.pref!.getString("token");
  // String? userNumber = IntroScreen.pref!.getString("UserNumber");

  int fire = 0;
  int hospital = 0;
  int police = 0;
  bool isCheck = false;

  bool initialFire = false;
  bool initialHospital = false;
  bool initialPolice = false;
  List<String> departmentId = [];

  int? fireId;
  final dio = Dio();

  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();

    // mainprovider = context.read<MainScreenProvider>();
    reportProvider = context.read<ReportProvider>();
    // print(" when i page open => ${selectedImages}");
    //
    // for (var x in mainprovider.fireList) {
    //   fireModel = Departments.fromJson(x.toJson());
    //   fireModelList.add(fireModel!);
    // }
    // for (var x in mainprovider.policeList) {
    //   policeModel = Departments.fromJson(x.toJson());
    //   policeModelList.add(policeModel!);
    // }
    // for (var x in mainprovider.hospitalDataList) {
    //   hospitalModel = Departments.fromJson(x.toJson());
    //   hospitalModelList.add(hospitalModel!);
    // }

    getCurrentLocation();
    // token = IntroScreen.pref!.getString("token");
    // userNumber = IntroScreen.pref!.getString("UserNumber");
    // print("token is ${token} ${userNumber}");

    // setState(() {});
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    // mainprovider = context.read<MainScreenProvider>();
    // reportProvider = context.read<ReportProvider>();
    //
    //   for (var x in mainprovider.fireList) {
    //     fireModel = Departments.fromJson(x.toJson());
    //     fireModelList.add(fireModel!);
    //   }
    //   for (var x in mainprovider.policeList) {
    //     policeModel = Departments.fromJson(x.toJson());
    //     policeModelList.add(policeModel!);
    //   }
    //   for (var x in mainprovider.hospitalDataList) {
    //     hospitalModel = Departments.fromJson(x.toJson());
    //     hospitalModelList.add(hospitalModel!);
    //   }
    //   // await getCurrentLocation();
    //   // setState(() {
    //   //
    //   // });
    //
    //   // token = IntroScreen.pref!.getString("token");
    //   // userNumber = IntroScreen.pref!.getString("UserNumber");
    //
    // });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("build report screen page ");
    // mainprovider = context.watch<MainScreenProvider>();
    reportProvider = context.watch<ReportProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.appbar,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Palette.white,
                ))
          ],
          centerTitle: true,
          title: const Text(
            "REPORT",
            style: TextStyle(
                fontSize: 28,
                decoration: TextDecoration.underline,
                color: Palette.commonColor),
          ),
          backgroundColor: Palette.appbar,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            h10,
            const Center(
              child: Text("SELECT LOCATION",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Palette.commoncolor,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            h5,
            Container(
              padding: const EdgeInsets.all(10),
              height: 45,
              width: 280,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down,
                    size: 30, color: Palette.appbar),
                value: selectedDesignation,
                underline: Container(),
                elevation: 5,
                isExpanded: true,
                hint: const Center(
                  child: Text("Add cheif fire officers",
                      style: TextStyle(
                        fontFamily: "Gilroy",
                      )),
                ),
                items: designation.map((organization) {
                  return DropdownMenuItem(
                    alignment: Alignment.center,
                    value: organization,
                    child: Text(organization),
                  );
                }).toList(),
                onChanged: (value) async {
                  // if(value == "Current Location")
                  {
                    setState(() {
                      selectedDesignation = value!;
                    });
                  }
                },
              ),
            ),
            h10,
            const Divider(
              height: 3,
              color: Colors.white,
              indent: 20,
              endIndent: 20,
            ),
            h10,
            Visibility(
              visible: true,
              // visible: token!.isEmpty,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30) +
                    const EdgeInsets.only(bottom: 5),
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Palette.appbar,
                  maxLength: 10,
                  decoration: InputDecoration(
                      counterText: "",
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter Your Contact Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  controller: contactNumber,
                ),
              ),
            ),
            const Text("SELECT SERVICE",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Palette.commoncolor,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            _cardWidget(),
            const Divider(
              height: 3,
              color: Colors.white,
              indent: 20,
              endIndent: 20,
            ),
            h10,
            Column(
              children: [
                InkWell(
                  onTap: showDataAlert,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: 100,
                        height: 100,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/fireImage.jpg",
                            ),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const Icon(Icons.camera_alt_outlined,
                          color: Colors.white60, size: 35),
                    ],
                  ),
                ),
                h10,
                selectedImages.isNotEmpty
                    ? SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: selectedImages.length,
                          itemBuilder: (context, index) {
                            if (isImageOrVideoFile(
                                    selectedImages[index].path) ==
                                true) {
                              return Card(
                                elevation: 5,
                                child: Container(
                                  margin: const EdgeInsets.all(2) +
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
                                    child: Image.file(selectedImages[index]),
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) {
                                      return VideoPlayerScreen(
                                        key: UniqueKey(),
                                        selectedImages[index],
                                        isPreview: false,
                                      );
                                    },
                                  ),
                                ),
                                child: Card(
                                  elevation: 5,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.all(4),
                                        child: VideoPlayerScreen(
                                          selectedImages[index],
                                          isPreview: true,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.play_circle,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            h10,
            _sizebox(),
            h10,
            const Center(
              child: Text("DESCRIBE",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Palette.commoncolor,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
            ),
            h5,
            _typeBox(),
            h10,
            _sizebox(),
            h10,
            _sendButton(),
            h10,
          ]),
        ),
      ),
    );
  }

  Widget _cardWidget() {
    return Container(
      color: Palette.mainColor,
      child: Column(
        children: [
          CardTitle(
            color: Colors.red,
            departmanet: "FIRE SERVICE",
            svg: "assets/fire.svg",
          ),
          Consumer<MainScreenProvider>(
            builder: (context, value, child) {

              return CarouselSlider.builder(
                carouselController: CarouselController(),
                itemCount: value.fireList1.length,
                itemBuilder: (BuildContext context, int i, int pageViewIndex) {
                  return value.fireList1.isNotEmpty
                      ? CardWidget(
                          shadow: false,
                          address: value.fireList1[i]["address"],
                          phoneNumber: value.fireList1[i]["number"][0],
                          stationName: value.fireList1[i]["name"],
                          color: initialFire
                              ? i == value.fire
                                  ? Colors.green
                                  : Palette.redLight
                              : Palette.redLight,
                          svg: 'assets/fire.svg',
                          onTap: () {
                            initialFire = true;
                            // fire = i;
                            value.setFire(i);
                            departmentId
                                .add(value.fireList1[i]["_id"].toString());
// setState(() {
//
// });
                          },

                          stationTitle: value.fireList1[i]["name"],
                          // ischeck: isCheck
                        )
                      : const SizedBox();
                },
                options: CarouselOptions(
                    height: 215.0,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    enlargeCenterPage: false,
                    viewportFraction: .85),
              );
            },
          ),
          // CarouselSlider.builder(
          //   carouselController: CarouselController(),
          //   itemCount: fireModelList.length,
          //   itemBuilder: (BuildContext context, int i, int pageViewIndex) {
          //     return fireModelList.isNotEmpty
          //         ? CardWidget(
          //             shadow: false,
          //             address: fireModelList[i].address,
          //             phoneNumber: removeBrackets("${fireModelList[i].number}"),
          //             stationName: fireModelList[i].name,
          //             color: initialFire
          //                 ? i == fire
          //                     ? Colors.green
          //                     : Palette.redLight
          //                 : Palette.redLight,
          //             svg: 'assets/fire.svg',
          //             onTap: () {
          //               initialFire = true;
          //               fire = i;
          //               departmentId.add(fireModelList[fire].sId.toString());
          //
          //               setState(() {});
          //               if (kDebugMode) {
          //                 print("Firestation id ==> ${fireModelList[i].sId}");
          //               }
          //             },
          //             stationTitle: fireModelList[i].name,
          //             // ischeck: isCheck
          //           )
          //         : const SizedBox();
          //   },
          //   options: CarouselOptions(
          //       height: 215.0,
          //       enableInfiniteScroll: false,
          //       initialPage: 0,
          //       enlargeCenterPage: false,
          //       viewportFraction: .85),
          // ),
          CardTitle(
            color: Palette.yellow,
            departmanet: "POLICE SERVICES",
            svg: "assets/Police.svg",
          ),
          Consumer<MainScreenProvider>(
            builder: (context, value, child) {
              return CarouselSlider.builder(
                itemCount: value.policeList1.length,
                itemBuilder: (BuildContext context, int i, int pageViewIndex) {
                  return value.policeList1.isNotEmpty
                      ? CardWidget(
                          shadow: false,
                          address: value.policeList1[i]["address"],
                          phoneNumber: value.policeList1[i]["number"][0],

                          stationName: value.policeList1[i]["name"],
                          color: initialPolice
                              ? i == value.police
                                  ? Colors.green
                                  : Palette.yellow
                              : Palette.yellow,
                          svg: 'assets/Police.svg',
                          onTap: () {
                            initialPolice = true;
                            // police = i;
                            value.setPolice(i);
                            departmentId
                                .add(value.policeList1[i]["_id"].toString());
                          },
                          stationTitle: value.policeList1[i]["name"],
                          // ischeck: false,
                        )
                      : const SizedBox();
                },
                options: CarouselOptions(
                    height: 215.0,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    enlargeCenterPage: false,
                    viewportFraction: .85),
              );
            },
          ),
          CardTitle(
            color: Palette.card_blue,
            departmanet: "HOSPITAL SERVICE",
            svg: "assets/heart-pulse.svg",
          ),
          Consumer<MainScreenProvider>(
            builder: (context, value, child) {
              return CarouselSlider.builder(
                itemCount: value.hospitalList1.length,
                itemBuilder: (BuildContext context, int i, int pageViewIndex) {
                  return value.hospitalList1.isNotEmpty
                      ? CardWidget(
                          shadow: false,
                          address: value.hospitalList1[i]["address"],

                          phoneNumber: value.hospitalList1[i]["number"][0],
                          stationName: value.hospitalList1[i]["name"],
                          color: initialHospital
                              ? i == value.hospital
                                  ? Colors.green
                                  : Palette.card_blue
                              : Palette.card_blue,
                          svg: "assets/heart-pulse.svg",
                          onTap: () {
                            initialHospital = true;
                            // hospital = i;
                            value.setHospital(i);
                            departmentId
                                .add(value.hospitalList1[i]["_id"].toString());
                          },
                          stationTitle: value.hospitalList1[i]["name"],
                          // ischeck: false,
                        )
                      : const SizedBox();
                },
                options: CarouselOptions(
                    height: 215.0,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    enlargeCenterPage: false,
                    viewportFraction: .85),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sizebox() {
    return const Divider(
      height: 3,
      color: Colors.white,
      indent: 20,
      endIndent: 20,
    );
  }

  Future<void> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    // setState(() {
    reportProvider.setLatlong(position.latitude, position.longitude);
    //   latitude = position.latitude;
    //   longitude = position.latitude;
    // });
  }

  Widget _typeBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        cursorColor: Palette.appbar,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Type..",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        controller: describeController,
      ),
    );
  }

  Widget _sendButton() {
    return Consumer<ReportProvider>(
      builder: (context, value, child) {
        return SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Palette.card_blue,
                  side: const BorderSide(width: 2, color: Palette.commoncolor)),
              onPressed: () async {
                print(value.location);
                reportProvider.ReportDioApi(
                  selectedImages[0],
                  value.location,

                  // [longitude!, latitude!],
                  contactNumber.text,
                  departmentId,
                  describeController.text,
                ).then(
                  (value) async {
                    if (kDebugMode) {}
                    if (value) {
                      ToastMassage()
                          .toastMeassage("Report upload successfully");

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const BottomNavBar();
                        },
                      ));
                    } else {
                      if (kDebugMode) {
                        print("invalid data");
                      }
                    }
                  },
                );
              },
              child: const Text(
                "SEND",
                style: TextStyle(fontSize: 20, color: Palette.commoncolor),
              )),
        );
      },
    );
  }

  showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Center(
              child: Text(
                "Image",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () async {
                            pickImageByCamera();
                            // pickImageByGallery();
                          },
                          child: Image.asset("assets/camera.png",
                              height: 50, width: 50)),
                    ],
                  ),
                  const Divider(
                    height: 2,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.black,
                  ),
                  h10,
                  const Center(
                    child: Text(
                      "Video",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                            await pickImageByGallery();
                            // await pickVideoByCamera();
                          },
                          child: Image.asset("assets/add_image.png",
                              height: 50, width: 50)),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool? isImageOrVideoFile(String fileName) {
    final lowerCaseFileName = fileName.toLowerCase();

    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

    final videoExtensions = ['.mp4', '.avi', '.mov', '.mkv', '.wmv', '.flv'];

    final fileExtension = path.extension(lowerCaseFileName);

    if (imageExtensions.contains(fileExtension)) {
      return true;
    } else if (videoExtensions.contains(fileExtension)) {
      return false;
    } else {
      return null;
    }
  }

  Future pickImageByGallery() async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      if (kDebugMode) {
        print("imgae path == > ${selectedImages[0]}");
      }
      setState(
        () {},
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
  }

  void pickImageByCamera() async {
    final XFile? pickedFileImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFileImage != null) {
      setState(() {
        selectedImages.add(File(pickedFileImage.path));
      });
    }
    Navigator.of(context).pop();
  }

  Future pickVideoByCamera() async {
    final XFile? pickedFileVideo =
        await picker.pickVideo(source: ImageSource.camera);
    if (pickedFileVideo != null) {
      setState(() {
        selectedImages.add(File(pickedFileVideo.path));

        if (kDebugMode) {
          print("image path == > ${selectedImages[0]}");
        }
      });
    }
  }

  String removeBrackets(String input) {
    if (input.startsWith('[') && input.endsWith(']')) {
      return input.substring(1, input.length - 1);
    } else if (input.startsWith('{') && input.endsWith('}')) {
      return input.substring(1, input.length - 1);
    } else if (input.startsWith('(') && input.endsWith(')')) {
      return input.substring(1, input.length - 1);
    } else {
      return input;
    }
  }
}
