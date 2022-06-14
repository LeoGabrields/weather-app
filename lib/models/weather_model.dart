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
  int? humidity;
  String? windSpeed;
  double? uvi;
  

  Weather({
    this.cityName,
    this.climate,
    this.temp,
    this.tempMax,
    this.tempMin,
    this.icon,
    this.dayWeather,
    this.humidity,
    this.uvi,
    this.weekDay,
    this.windSpeed,
   
  });

  Weather.fromJson(Map<String, dynamic> json, Map jsonCity) {
    climate = jsonCity['weather'][0]['description'];
    temp = (jsonCity['main']['temp'] as double).toStringAsFixed(0);
    icon = jsonCity['weather'][0]['icon'];
    humidity = jsonCity['main']['humidity'];
    windSpeed = (jsonCity['wind']['speed'] * 3.6 as double).toStringAsFixed(0);
    uvi = json['current']['uvi'];
    dayWeather = json['daily'];
    cityName = jsonCity['name'];
    weekDay = WeatherApi().getWeekDay();
  }
}
