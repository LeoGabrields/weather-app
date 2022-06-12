import 'package:weather_app/api/weather_api.dart';

class Weather {
  String? cityName;
  String? climate;
  String? temp;
  String? tempMax;
  String? tempMin;
  String? icon;
  List? dayWeather;
  List? weekDay;

  Weather({
    this.cityName,
    this.climate,
    this.temp,
    this.tempMax,
    this.tempMin,
    this.icon,
    this.dayWeather,
  });

  Weather.fromJson(Map<String, dynamic> json, List jsonCity) {
    climate = json['current']['weather'][0]['description'];
    temp = (json['current']['temp'] as double).toStringAsFixed(0);
    icon = json['current']['weather'][0]['icon'];
    dayWeather = json['daily'];
    cityName = jsonCity[0]['name'];
    weekDay = WeatherApi().getWeekDay();
  }
}