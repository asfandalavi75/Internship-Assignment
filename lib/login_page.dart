import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './imports/background_shapes.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            child: CustomPaint(painter: BackgroundShapes(), child: Container()),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Log In",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                color: Colors.indigo,
              ),
            ),
          )
        ],
      ),
    );
  }
}