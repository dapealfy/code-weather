import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weathervoir/constants.dart';
import 'package:weathervoir/main.dart';
import 'package:weathervoir/src/models/weather_model.dart';

class WeatherApiProvider {
  Future<WeatherModel> fetchWeather() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position userPosition;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Lokasi tidak dapat digunakan.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Lokasi tidak diizinkan');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Izin lokasi tidak dapat kami akses');
    }

    userPosition = await Geolocator.getCurrentPosition();

    if (userPosition != null) {
      final response = await dio.get(
          'http://api.openweathermap.org/data/2.5/weather?lat=-6.1768293&lon=106.790902&APPID=${AppConstants.apiKey}');
      print(response);
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception('Failed to load weather');
      }
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
