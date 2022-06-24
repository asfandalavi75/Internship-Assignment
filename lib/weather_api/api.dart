import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

class Api {
  void getWeather() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final String host = 'api.weather.gov';
    Uri uri({String? lat, String? lon}) => Uri(
          scheme: "https",
          host: host,
          pathSegments: {"points"},
          queryParameters: {
            "lat": lat,
            "lon": lon,
          },
        );

    final requestUri = uri(
      lon: position.longitude.toString(),
      lat: position.latitude.toString(),
    );
    final response = await http.get(requestUri);

    final decodedJson = json.decode(response.body);
  }
}
