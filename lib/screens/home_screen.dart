import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/day_details.dart';
import '../api/weather_api.dart';
import '../widgets/custom_painter.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            size: 30,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                'assets/images/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 06, 06, 40),
      body: FutureBuilder(
        future: api.getData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Erro',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: size.height * 0.55,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70),
                          Text(
                            api.data.cityName!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            DateFormat('HH:mm - dd MMMM yyyy', 'pt_br')
                                .format(DateTime.now()),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            (api.data.temp!) + '°',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                'http://openweathermap.org/img/wn/${api.data.icon}@2x.png',
                                width: 50,
                              ),
                              Text(
                                api.data.climate!,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
                      color: Colors.black54,
                      width: size.width * 1,
                      height: size.height * 0.45,
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 1,
                            height: size.height * 0.13,
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ListView.builder(
                              addAutomaticKeepAlives: true,
                              itemCount: api.data.dayWeather!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                final dayWeather = api.data.dayWeather![index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      print(api.data.dayWeather![index]);
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 1, color: Colors.white24),
                                      ),
                                      height: size.height * 0.13,
                                      width: size.width * 0.17,
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(api.data.weekDay![index],
                                              style: const TextStyle(
                                                fontSize: 12,
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
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                (dayWeather['temp']['min']
                                                            as num)
                                                        .toStringAsFixed(0) +
                                                    '°',
                                                style: const TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 12),
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
                          DayDetails(api: api)
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
    );
  }
}
