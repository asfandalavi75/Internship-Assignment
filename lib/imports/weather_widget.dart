import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../weather_api/api.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherWidget extends StatelessWidget {
  WeatherWidget({Key? key}) : super(key: key);
  final weatherApi = WeatherApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weatherApi.getWeather(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Weather? weatherDets = snapshot.data as Weather?;
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), //color of shadow
                      spreadRadius: 5, //spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(0, 2), // changes position of shadow
                      //first paramerter of offset is left-right
                      //second parameter is top to down
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    //Shows City
                    Text(
                      weatherDets!.city.toString(),
                      style: GoogleFonts.lato(
                        fontSize: 50,
                        color: Colors.black,
                      ),
                    ),
                    //Icon representing current weather and time of day
                    Image.network(
                      weatherDets.icon.toString(),
                      height: 50,
                      width: 50,
                    ),
                    // current time period
                    Text(
                      weatherDets.timeperiod.toString(),
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    // Current Temperature
                    Text(
                      weatherDets.temp.toString() + " °F",
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        color: Colors.indigo,
                      ),
                    ),
                    Text(
                      weatherDets.shortForecast.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
