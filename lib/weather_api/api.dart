import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import '../models/weather.dart';

class WeatherApi {
  Future<Position> _determineCurrentPositionStarting() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('not enabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print('No permission');
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        print('No permission');
      }
    }

    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      print("denied");
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    // ignore: unnecessary_cast
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true,
      timeLimit: null,
    );
  }

  Future<Weather?>? getWeather() async {
    Position pos =
        await _determineCurrentPositionStarting(); //Position object which is then used to get current lon and lat points(using geolocator package)
    final String host = 'api.weather.gov';
    Uri uri({String? lat, String? lon}) => Uri(
          scheme: "https",
          host: host,
          pathSegments: {
            "points",
            pos.latitude.toString() + "," + pos.longitude.toString()
          },
        );

    final requestUri = uri(
      lon: pos.longitude.toString(),
      lat: pos.latitude.toString(),
    );
    final response = await http.get(requestUri);
    //initial json, which contains the foreCast uri
    final decodedJson = json.decode(response.body);
    //get uri with forcast details
    Map<String, dynamic> properties = decodedJson['properties'];
    Uri forcastUri = Uri.parse(properties['forecast']);
    var city = properties['relativeLocation']['properties']['city'];
    //get json from the forcast uri
    final forecastResponse = await http.get(forcastUri);
    final forecastDecodedJson = json.decode(forecastResponse.body);
    // most recent weather details from forcast uri
    final weatherDetails = forecastDecodedJson['properties']['periods'][0];

    Weather currWeather = Weather.fromMap(weatherDetails, city);

    return currWeather;
  }
}
