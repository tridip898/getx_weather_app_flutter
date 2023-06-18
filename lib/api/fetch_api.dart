import 'dart:convert';
import 'package:getx_weather_app/api/api_key.dart';
import 'package:getx_weather_app/models/weather_data.dart';
import 'package:getx_weather_app/models/weather_data_current.dart';
import 'package:http/http.dart' as http;

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> fetchWeatherData(lat, lon) async {
    var response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely"));
    var jsonString=jsonDecode(response.body);
    weatherData=WeatherData(WeatherDataCurrent.fromJson(jsonString));
    return weatherData!;
  }
}
