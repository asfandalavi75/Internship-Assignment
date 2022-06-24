import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_assignment/login_page.dart';
import '../signup_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  Color emailColor = Colors.white;
  Color passColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
            child: Text(
              "Email",
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          /////////////////Email TextField Start
          Container(
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
                //you can set more BoxShadow() here
              ],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: emailColor,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: MediaQuery.of(context).size.height * 0.07,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onFieldSubmitted: (emailCheck) {
                emailCheck = emailController.value.text;
                setState(() {
                  if (emailCheck.length > 8) {
                    emailColor = Colors.white;
                  } else {
                    emailColor = Colors.red;
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
            child: Text(
              "Password",
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          /////////////////Email TextField End

          //////////////// Password TextField Start
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: MediaQuery.of(context).size.height * 0.07,
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
              border: Border.all(
                color: passColor,
                width: 2,
              ),
            ),
            child: TextFormField(
              controller: passwordController,
              obscureText: _isHidden,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffix: InkWell(
                  onTap: _togglePasswordView,
                  child: Icon(
                    _isHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                //eye icon if passenable = true, else, Icon is ***__
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onFieldSubmitted: (passCheck) {
                passCheck = passwordController.value.text;
                setState(() {
                  if (passCheck.length >= 8) {
                    passColor = Colors.white;
                  } else {
                    passColor = Colors.red;
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {}
                return null;
              },
            ),
          ),
          //////////////// Password TextField End
          const ForgetPassButton(),

          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                onPressed: logIn,
                child: Text(
                  "Log In",
                  style: GoogleFonts.lato(
                    fontSize: 25,
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: 90),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    "New user? Create account",
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      color: Colors.indigo,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.white; // Use the component's default.
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                              width: 2.0, color: Colors.indigo)),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future logIn() async {
    if (passwordController.text.length >= 8 &&
        emailController.text.length > 8) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String error = e.message.toString();
            return AlertDialog(
              title: Text(error),
              actions: <Widget>[
                ElevatedButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        print(e);
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String error = "Enter a Valid Password and Email.";
          return AlertDialog(
            title: Text(error),
            actions: <Widget>[
              ElevatedButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

class ForgetPassButton extends StatelessWidget {
  const ForgetPassButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Forgot Password?",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
