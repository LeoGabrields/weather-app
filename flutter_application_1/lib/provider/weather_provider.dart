import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import '../models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  final Map<String, WeatherModel> weather = {};
  late String linkApi;

  Future<void> currentLocation() async {
    final response = await Location().getLocation();
    final String lat = response.latitude.toString();
    final String lon = response.longitude.toString();
    const String apiKey = 'bff7cddd184de822d84f2fa8ac558edf';

    linkApi = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&lang=pt_br&units=metric';

    notifyListeners();
    loadWeather();
  }

  Future<void> loadWeather() async {
    final response = await http.get(Uri.parse(linkApi));
    var responseBody = jsonDecode(response.body);

     weather.addAll({
      'weather': WeatherModel(
        cityName: responseBody['name'],
        climate: responseBody['weather'][0]['description'],
        country: responseBody['sys']['country'],
        tempMax: responseBody['main']['temp_max'],
        tempMin: responseBody['main']['temp_min'],
        temp: responseBody['main']['temp'],
        windSpeed: responseBody['wind']['speed'],
        clima: responseBody['weather'][0]['main'],
        icon: responseBody['weather'][0]['icon'],
      )
    });
    notifyListeners();
  }
}