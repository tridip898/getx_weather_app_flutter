import 'package:flutter/material.dart';
import 'package:getx_weather_app/controller/golbal_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../widgets/current_weather_widget.dart';
import '../widgets/headerWidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalController controller =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        if (controller.checkLoading().isTrue) {
          return const Center(
            child: Text("wait")
          );
        } else {
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              const HeaderWidget(),
              ///for our current temperature
              // CurrentWeatherWidget(
              //   weatherDataCurrent: controller.getWeatherData().getCurrentWeather(),
              // ),
            ],
          );
        }
      }),
    ));
  }
}
