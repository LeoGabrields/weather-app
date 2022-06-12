import 'package:flutter/material.dart';
import '../api/weather_api.dart';
import '../components/custom_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    WeatherApi api = WeatherApi();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 06, 06, 40),
        body: FutureBuilder(
          future: api.getData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else {
              return Stack(
                children: [
                  SizedBox(
                    height: size.height * 0.55,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                api.data.cityName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.055),
                          Image.network(
                            'http://openweathermap.org/img/wn/${api.data.icon}@2x.png',
                          ),
                          Text(
                            (api.data.temp!) + '°',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            api.data.climate!,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    width: size.width * 1,
                    bottom: size.height * 0.45,
                    child: CustomPaint(
                      size: Size(double.maxFinite, (200 * 0.5).toDouble()),
                      painter: RPSCustomPainter(),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.white10,
                        width: size.width * 1,
                        height: size.height * 0.45,
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width * 1,
                              height: 100,
                              child: ListView.builder(
                                addAutomaticKeepAlives: true,
                                itemCount: api.data.dayWeather!.length,
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                itemBuilder: (ctx, index) {
                                  final dayWeather =
                                      api.data.dayWeather![index];
                                  return Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              width: 1, color: Colors.white24)),
                                      height: 55,
                                      width: 55,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(api.data.weekDay![index],
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                )),
                                            Image.network(
                                                'http://openweathermap.org/img/wn/${dayWeather['weather'][0]['icon']}@2x.png'),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  (dayWeather['temp']['max']
                                                              as num)
                                                          .toStringAsFixed(0) +
                                                      '° ',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                                Text(
                                                  (dayWeather['temp']['min']
                                                              as num)
                                                          .toStringAsFixed(0) +
                                                      '°',
                                                  style: const TextStyle(
                                                      color: Colors.white54,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}