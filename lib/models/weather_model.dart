class WeatherModel {
  final String cityName;
  final String country;
  final String climate;
  final double windSpeed;
  final double minTemp;
  final double maxTemp;
  final double temp;
  final String clima;

  WeatherModel({
    required this.climate,
    required this.country,
    required this.cityName,
    required this.windSpeed,
    required this.minTemp,
    required this.maxTemp,
    required this.temp,
    required this.clima
  });
}
