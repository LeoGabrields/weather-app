import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:weather_app/api/api_key.dart';
import '../models/weather_model.dart';

class WeatherApi {
  late Weather data;

  Future<void> getData() async {
    data = await getCurrentWeather();
  }

  Future<Weather> getCurrentWeather() async {
    String apiKey = ApiKey().key;

    var resp = await Location().getLocation();

    final urlCity = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${resp.latitude}&lon=${resp.longitude}&units=metric&lang=pt_br&appid=$apiKey');
    var respCity = await http.get(urlCity);
    var cityBody = jsonDecode(respCity.body);

    final urlApi = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${resp.latitude}&lon=${resp.longitude}&units=metric&lang=pt_br&appid=$apiKey');
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
