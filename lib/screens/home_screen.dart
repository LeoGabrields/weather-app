import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final response = Location().getLocation();
    response.then(
      (value) => Provider.of<WeatherProvider>(context, listen: false).location(
        latitude: value.latitude!,
        longitude: value.longitude!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).weather['weather'];

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(weather?.cityName ?? ''),
            Text((weather?.temp.toStringAsFixed(0) ?? '') + '°C')
          ],
        ),
      ),
    );
  }
}
