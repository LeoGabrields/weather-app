import 'package:flutter/material.dart';
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
    Provider.of<WeatherProvider>(context, listen: false).currentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).weather['weather'];

    String imageWeather() {
      String chuva = 'lib/assets/images/chuva.jpg';
      String sol = 'lib/assets/images/sol.jpg';
      String neve = 'lib/assets/images/neve.jpg';
      String nublado = 'lib/assets/images/nublado.jpg';

      if (weather?.clima == 'Sun') {
        return sol;
      }
      if (weather?.clima == 'Rain') {
        return chuva;
      }
      if (weather?.clima == 'Snow') {
        return neve;
      }
      if (weather?.clima == 'Clouds') {
        return nublado;
      }
      return sol;
    }

    Widget customText(String title, String temp, [double size = 20.0]) {
      return Text(
        title + temp + '°C',
        style: TextStyle(color: Colors.white, fontSize: size),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageWeather()),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Card(
                  elevation: 10,
                  color: Colors.black45,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              weather?.cityName ?? '',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 17),
                            ),
                            customText(
                                '', weather?.temp.toStringAsFixed(0) ?? '', 65),
                            Row(
                              children: [
                                customText(
                                    'Temp.max: ',
                                    weather?.tempMax.toStringAsFixed(0) ?? '',
                                    13),
                                const SizedBox(width: 10),
                                customText(
                                    'Temp.min: ',
                                    weather?.tempMin.toStringAsFixed(0) ?? '',
                                    13),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.network(
                              'http://openweathermap.org/img/wn/${weather?.icon ?? '01n'}@2x.png',
                              width: 80,
                            ),
                            Text(
                              weather?.climate ?? '',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width * 1,
            top: MediaQuery.of(context).size.height * 0.4,
            bottom: 0,
            child: Container(
              color: Colors.black38,
            ),
          )
        ],
      ),
    );
  }
}