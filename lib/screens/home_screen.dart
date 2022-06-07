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
    Provider.of<WeatherProvider>(context, listen: false).location(
      latitude: -22.738823,
      longitude: -48.795562,
    );
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).weather['weather'];

    Future<void> myLocation() async {
      final s = await Location().getLocation();

      Provider.of<WeatherProvider>(context, listen: false).location(
        latitude: s.latitude!,
        longitude: s.longitude!,
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: myLocation,
              child: const Text('Minha Localização'),
            ),
            Text(weather?.cityName ?? ''),
            Text((weather?.temp.toStringAsFixed(0) ?? '') + '°C')
          ],
        ),
      ),
    );
  }
}
