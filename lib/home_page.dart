import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internship_assignment/imports/weather_widget.dart';
import './imports/funcs/db_user_funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import './imports/background_shapes.dart';
import './weather_api/api.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final weatherApi = WeatherApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getUserName(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: CustomPaint(
                      painter: BackgroundShapes(), child: Container()),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text(
                      "Welcome!",
                      style: GoogleFonts.lato(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    snapshot.data.toString(),
                    style: GoogleFonts.lato(
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                WeatherWidget(),
                Container(
                  margin: const EdgeInsets.all(40),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: ElevatedButton(
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      child: Text(
                        "Sign Out",
                        style: GoogleFonts.lato(
                          fontSize: 30,
                        ),
                      )),
                ),
                // Container(
                //   margin: const EdgeInsets.all(40),
                //   height: MediaQuery.of(context).size.height * 0.07,
                //   width: MediaQuery.of(context).size.width * 0.55,
                //   child: ElevatedButton(
                //       onPressed: weatherApi.getWeather,
                //       child: const Text("Weather Button")),
                // ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
