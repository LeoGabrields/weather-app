import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'provider/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false).location(-22.738823 , -48.795562);
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).tempo['weather'];

    Future<void> myLocation() async {
      final s = await Location().getLocation();

      Provider.of<WeatherProvider>(context, listen: false)
          .location(s.latitude!, s.longitude!);
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
