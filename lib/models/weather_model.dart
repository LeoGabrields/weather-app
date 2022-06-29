// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';

class Weather with ChangeNotifier {
  var cityName;
  var tempMax;
  var tempMin;
  var temp;
  var icon;
  var humidity;
  var windSpeed;
  var description;

  Weather({
    this.cityName,
    this.tempMax,
    this.tempMin,
    this.icon,
    this.humidity,
    this.windSpeed,
    this.temp,
    this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      humidity: json['main']['humidity'],
      icon:
          'http://openweathermap.org/img/wn/${json['weather'][0]['icon']}@2x.png',
      tempMax: json['main']['temp_max'],
      tempMin: json['main']['temp_min'],
      windSpeed: json['wind']['speed'],
      temp: (json['main']['temp'] as num).toStringAsFixed(0),
      description: json['weather'][0]['description']
    );
  }
}
