import 'package:rxdart/rxdart.dart';
import 'package:weathervoir/src/models/weather_model.dart';
import 'package:weathervoir/src/resources/repository.dart';

class WeatherBloc {
  final _repository = Repository();
  final _weatherFetcher = PublishSubject<WeatherModel>();

  Stream<WeatherModel> get weatherData => _weatherFetcher.stream;

  fetchAllMovies() async {
    WeatherModel weatherModel = await _repository.fetchWeatherData();
    _weatherFetcher.sink.add(weatherModel);
  }

  dispose() {
    _weatherFetcher.close();
  }
}

final bloc = WeatherBloc();
