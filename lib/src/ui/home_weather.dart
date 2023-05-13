import 'package:flutter/material.dart';
import 'package:weathervoir/src/blocs/weather_bloc.dart';
import 'package:weathervoir/src/models/weather_model.dart';

class HomeWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: bloc.weatherData,
              builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<WeatherModel> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          snapshot.data!.weather![0].main == 'Clouds'
              ? Icons.cloud
              : Icons.sunny,
          size: 86,
          color: Colors.white,
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          (double.parse(snapshot.data!.main!.temp.toString()) - 273.15)
                  .toString()
                  .substring(0, 2) +
              '°C',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Humidity: ' + snapshot.data!.main!.humidity.toString(),
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              'Visibility: ' +
                  (int.parse(snapshot.data!.visibility.toString()) / 1000)
                      .toString() +
                  'm',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              'Feels Like: ' +
                  (double.parse(snapshot.data!.main!.feelsLike.toString()) -
                          273.15)
                      .toString()
                      .substring(0, 2) +
                  '°C',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ],
        ),
      ],
    );
  }
}
