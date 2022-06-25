class Weather {
  final int temp;
  final String city;
  final String shortForecast;
  final String icon;
  final String timeperiod;

  Weather.fromMap(Map<String, dynamic> json, String cityName)
      : temp = json['temperature'].toInt(),
        city = cityName,
        shortForecast = json['shortForecast'],
        timeperiod = json['name'],
        icon = json['icon'];
}
