import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  final Map<String, WeatherModel> tempo = {};
  String? linkApi;

  void location([double lat = 0.0, double lon = 0.0]) {
    linkApi =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=bff7cddd184de822d84f2fa8ac558edf';
    notifyListeners();
    loadWeather();
  }

  Future<void> loadWeather() async {
    final response = await http.get(Uri.parse(linkApi!));
    var responseBody = jsonDecode(response.body);

    tempo.addAll({
      'weather': WeatherModel(
        cityName: responseBody['name'],
        climate: responseBody['weather'][0]['description'],
        country: responseBody['sys']['country'],
        maxTemp: responseBody['main']['temp_max'],
        minTemp: responseBody['main']['temp_min'],
        temp: (responseBody['main']['temp'] as double) - 273.15,
        windSpeed: responseBody['wind']['speed'],
      )
    });
    notifyListeners();
  }
}
