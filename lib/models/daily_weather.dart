// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DailyWeather with ChangeNotifier {
  var humidity;
  var icon;
  var uvi;
  var feelsLike;
  var temp;
  var tempMax;
  var tempMin;
  var weekDay;
  var windSpeed;

  DailyWeather({
    this.uvi,
    this.humidity,
    this.icon,
    this.temp,
    this.tempMax,
    this.tempMin,
    this.weekDay,
    this.windSpeed,
    this.feelsLike
  });

  static DailyWeather fromDailyJson(Map<String, dynamic> json) {
    return DailyWeather(
      humidity: json['humidity'],
      icon: json['weather'][0]['icon'],
      temp: json['temp']['day'],
      tempMax: json['temp']['max'],
      tempMin: json['temp']['min'],
      uvi: (json['uvi'] as num).toStringAsFixed(0),
      windSpeed: (json['wind_speed'] * 3.6 as num).toStringAsFixed(0),
      feelsLike: (json['feels_like']['day'] as num).toStringAsFixed(0),
      weekDay: getWeekDay(),
    );
  }

  static List getWeekDay() {
    var listWeekDay = List.generate(8, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      return DateFormat('EEE.', 'pt_BR').format(weekDay);
    }).reversed.toList();

    listWeekDay.remove(listWeekDay[0]);
    listWeekDay.insert(0, 'Hoje');

    return listWeekDay;
  }
}
