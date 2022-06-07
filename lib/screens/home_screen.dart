import 'package:flutter/cupertino.dart';
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

    String climate() {
      String chuva = 'lib/assets/images/chuva.jpg';
      String sol = 'lib/assets/images/sol.jpg';
      String neve = 'lib/assets/images/neve.jpg';

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
        return chuva;
      }
      return '';
    }

    print(climate());

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(climate()),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Card(
                  elevation: 10,
                  color: Colors.black45,
                  margin: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Text(
                        weather?.cityName ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      Center(
                        child: Text(
                            (weather?.temp.toStringAsFixed(0) ?? '') + '°C',
                            style:
                                TextStyle(color: Colors.white, fontSize: 80.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.black38,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.cloud,
                          color: Colors.white,
                        ),
                        Spacer(),
                        Divider(color: Colors.white,height: 50, thickness: 10),
                        Text(
                          weather?.climate ?? '',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.wb_sunny,
                          color: Colors.white,
                        ),
                        Spacer(),
                        Text(
                            'Temp.max ' +
                                (weather?.maxTemp.toStringAsFixed(0) ?? '') +
                                '°C',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        Text(
                            'Temp.min ' +
                                (weather?.minTemp.toStringAsFixed(0) ?? '') +
                                '°C',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
