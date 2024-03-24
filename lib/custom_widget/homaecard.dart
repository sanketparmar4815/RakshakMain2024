import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakashkh/app/dimensions.dart';

class HomeCard extends StatefulWidget {
  String? phoneNumber;
  String? address;
  String? stationName;
  String? stationTitle;
  Color color;
  String svg;
  void Function()? onTap;

  HomeCard({
    super.key,
    required this.address,
    required this.phoneNumber,
    required this.stationName,
    required this.stationTitle,
    required this.color,
    required this.svg,
    required this.onTap,
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        color: Colors.transparent,
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),

            ),
            height: 60,
            width: 310,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    w15,

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(widget.stationTitle!.toUpperCase(),
                            maxLines: 2,
                            style: const TextStyle(


                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    w5,
                    SvgPicture.asset(
                      height: 25,
                      widget.svg,
                      // color: widget.color,
                      color: Colors.white,
                    ),
                    w15,
                  ]
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 140,
            width: 310,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text("${widget.stationName}",
                      style: TextStyle(
                          color: widget.color,
                          fontSize: 15,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                            text: "Phone :  ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Gilroy",
                                color: Colors.black)),
                        TextSpan(
                            text: widget.phoneNumber,
                            style: const TextStyle(
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),

                   child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                                text: "Address :  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Gilroy",
                                    color: Colors.black)),
                            TextSpan(
                                text: widget.address!.toUpperCase(),
                                style: const TextStyle(
                                    fontFamily: "Gilroy",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ],
                        ),
                      ),


                    // child: LayoutBuilder(builder: (context, constraint) {
                    //    int charWidth=widget.address!.length;
                    //
                    //   double maxWidth = constraint.biggest.width;
                    //
                    //
                    //   int charsPerLine = maxWidth ~/ charWidth;
                    //
                    //
                    //   double fontSize = (widget.address!.length <= charsPerLine) ? 17.0 : 15.0;
                    //
                    //   return  Text(
                    //    "Address : ${widget.address!.toUpperCase()}",
                    //
                    //     style:  TextStyle(fontSize: fontSize,  fontFamily: "Gilroy",
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.black),
                    //   );
                    // },

                    ),
                  ),

              ],
            ),
          ),
        ]),
      ),
    );
  }
}