import 'package:weathervoir/src/models/weather_model.dart';
import 'package:weathervoir/src/resources/weather_api_providers.dart';

class Repository {
  final weatherApiProvider = WeatherApiProvider();

  Future<WeatherModel> fetchWeatherData() => weatherApiProvider.fetchWeather();
}
