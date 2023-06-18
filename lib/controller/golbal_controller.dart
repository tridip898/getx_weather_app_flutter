import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getx_weather_app/api/fetch_api.dart';
import 'package:getx_weather_app/models/weather_data.dart';

class GlobalController extends GetxController {
  //create various variables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  //instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData=WeatherData().obs;

  WeatherData getWeatherData(){
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      geoLocation();
    }
    super.onInit();
  }

  geoLocation() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location service are disabled");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission are denied");
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      ///update the latitude and longitude value
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      ///calling api
      return FetchWeatherAPI().fetchWeatherData(value.latitude, value.longitude).then((value) {
        weatherData.value=value;
        _isLoading.value = false;
      });
    });
  }
}
