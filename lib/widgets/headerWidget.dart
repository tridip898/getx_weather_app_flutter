import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:getx_weather_app/controller/golbal_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat.yMMMd().format(DateTime.now());

  final GlobalController controller =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(controller.getLatitude().value, controller.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 30),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 05),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500),
          ),
        )
      ],
    );
  }
}
