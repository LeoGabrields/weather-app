import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import '../api/api_key.dart';
import '../models/daily_weather.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = key;
  Weather weather = Weather();
  List<DailyWeather> sevenDays = [];
  List dias = [];
  bool isLoading = false;

  getWeatherData() async {
    isLoading = true;
    var locData = await Location().getLocation();
    var lat = locData.latitude;
    var lon = locData.longitude;
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=pt_br&units=metric&appid=$apiKey');
    Uri dailyUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&lang=pt_br&units=metric&exclude=minutely,hourly,alerts&appid=$apiKey');
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    weather = Weather.fromJson(body);

    final responseDaily = await http.get(dailyUrl);
    final dailyData = jsonDecode(responseDaily.body);

    List items = dailyData['daily'];
    dias = items;
    print(items);
    List<DailyWeather> dailys = items
        .map((item) => DailyWeather.fromDailyJson(item))
        .toList()
        .take(8)
        .toList();
    sevenDays = dailys;

    isLoading = false;
    notifyListeners();
  }

  searchWeatherData(String location) async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&lang=pt_br&appid=$apiKey');
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    weather = Weather.fromJson(body);
    print(body);
    notifyListeners();
  }
}
