import 'package:flutter/material.dart';
import 'package:getx_weather_app/models/weather_data_current.dart';
import 'package:sizer/sizer.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const CurrentWeatherWidget({Key? key, required this.weatherDataCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${weatherDataCurrent.current.weather![0].description}"),
    );
  }
}
