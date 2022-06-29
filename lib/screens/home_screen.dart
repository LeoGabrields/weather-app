import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_api.dart';
import '../models/daily_weather.dart';
import '../widgets/custom_painter.dart';
import '../widgets/day_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textController = TextEditingController();
  int _count = 0;
  bool isSearch = false;
  List day = [];

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<WeatherProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            setState(() => isSearch = true);
          },
          icon: const Icon(
            Icons.search,
            size: 30,
          ),
        ),
        title: isSearch
            ? TextField(
                controller: _textController,
                onSubmitted: (value) {
                  data.searchWeatherData(value);
                },
              )
            : null,
        actions: [
          isSearch
              ? IconButton(
                  onPressed: () {
                    setState(() => isSearch = false);
                  },
                  icon: const Icon(Icons.close),
                )
              : GestureDetector(
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
      body: data.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refreshData(context),
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: size.height * 0.55,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 70),
                        Text(
                          data.weather.cityName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          DateFormat('EEEE, dd MMMM', 'pt_br').format(
                            DateTime.now(),
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          children: [
                            Text(
                              (data.weather.temp).toString() + '°',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data.weather.icon,
                                  width: 50,
                                ),
                                Text(
                                  data.weather.description,
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
                        height: size.height * 0.45,
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 18, right: 18),
                              height: size.height * 0.14,
                              child: ListView.builder(
                                itemCount: Provider.of<WeatherProvider>(context)
                                    .sevenDays
                                    .length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  DailyWeather data =
                                      Provider.of<WeatherProvider>(context)
                                          .sevenDays[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: _count == index
                                          ? null
                                          : () {
                                              setState(() {
                                                _count = index;
                                                day.clear();
                                                day.insert(
                                                  0,
                                                  Provider.of<WeatherProvider>(
                                                          context,
                                                          listen: false)
                                                      .dias[index],
                                                );
                                              });
                                            },
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _count == index
                                              ? Colors.blue
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              width: 1, color: Colors.white24),
                                        ),
                                        height: size.height * 0.13,
                                        width: size.width * 0.18,
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              data.weekDay![index],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Image.network(
                                                'http://openweathermap.org/img/wn/${data.icon}@2x.png'),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  (data.tempMax as num)
                                                          .toStringAsFixed(0) +
                                                      '° ',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  (data.tempMin as num)
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
                            DayDetails(day: day),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
