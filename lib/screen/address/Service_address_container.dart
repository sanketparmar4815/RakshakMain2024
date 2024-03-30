import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakashkh/app/dimensions.dart';

class ServiceAddress extends StatefulWidget {
  final String? address;
  final String? addressType;
  final void Function()? delete;
  const ServiceAddress(
      {super.key,
      required this.address,
      required this.addressType,
      required this.delete});

  @override
  State<ServiceAddress> createState() => _ServiceAddressState();
}

class _ServiceAddressState extends State<ServiceAddress> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          h10,
          Row(children: [
            w20,
            Text(
              "${widget.addressType}",
              style: const TextStyle(
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            w10,
            SvgPicture.asset(
              "assets/map-location.svg",
              height: 25,
            ),
            SizedBox(
              width: width * 0.2546,
            ),
            InkWell(
              onTap: widget.delete,
              child: SvgPicture.asset(
                "assets/trash-can-solid.svg",
                height: 25,
              ),
            ),
          ]),
          const Divider(indent: 20, endIndent: 20),
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("\u2022"),
                    Expanded(child: Text("${widget.address}")),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
