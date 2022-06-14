import 'package:flutter/material.dart';
import '../api/weather_api.dart';

class DayDetails extends StatelessWidget {
  final WeatherApi api;

  const DayDetails({Key? key, required this.api}) : super(key: key);

  Widget _weatherInfoBuilder(
      String header, String body, String icon, double size) {
    return Container(
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Colors.white24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/$icon.png'),
                ),
              ),
              height: 30,
              width: 30,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  body,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
              FittedBox(
                child: Text(
                  header,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _weatherInfoBuilder('Umidade', '${api.data.humidity}%',
                  'icon-weathe', width * 0.42),
              _weatherInfoBuilder('UV', '${api.data.uvi}', 'icon-uv', width * 0.42),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _weatherInfoBuilder('Vento', '${api.data.windSpeed} km/h',
                  'icon-wind', width * 0.42),
              _weatherInfoBuilder('-', '-', 'icon-wind', width * 0.42),
            ],
          ),
        ],
      ),
    );
  }
}
