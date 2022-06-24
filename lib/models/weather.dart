class Weather {
  final int temp;
  final String city;
  final String country;
  final String main;
  final String desc;
  final String icon;

  Weather.fromMap(Map<String, dynamic> json)
      : temp = json['main']['temp'].toInt(),
        city = json['name'],
        country = json['sys']['country'],
        main = json['weather'][0]['main'],
        desc = json['weather'][0]['description'],
        icon = json['weather'][0]['icon'];
}
