import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import '../models/weather_model.dart';

class WeatherApi {
  late Weather data;

  Future<void> getData() async {
    data = await getCurrentWeather();
  }

  Future<Weather> getCurrentWeather() async {
    String baseUrl = 'https://api.openweathermap.org';
    String apiKey = '64a103bc1efc8c01497b73c92a7f6e3c';
    
    var resp = await Location().getLocation();
    
    final urlCity = Uri.parse(
        '$baseUrl/geo/1.0/reverse?lat=${resp.latitude}&lon=${resp.longitude}&appid=$apiKey');
    var respCity = await http.get(urlCity);
    var cityBody = jsonDecode(respCity.body);

    final urlApi = Uri.parse(
        '$baseUrl/data/2.5/onecall?lat=${resp.latitude}&lon=${resp.longitude}&units=metric&lang=pt_br&appid=$apiKey');
    var response = await http.get(urlApi);
    var body = jsonDecode(response.body);
    
    return Weather.fromJson(body, cityBody);
  }

  List getWeekDay() {
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