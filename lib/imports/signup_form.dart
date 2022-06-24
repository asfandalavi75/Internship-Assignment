import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_assignment/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  Color nameColor = Colors.white;
  Color emailColor = Colors.white;
  Color passColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Label
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
            child: Text(
              "Name",
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          ///////// Name TextField Start
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
              ],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: nameColor,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: MediaQuery.of(context).size.height * 0.07,
            child: TextFormField(
              controller: nameController,
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
              onFieldSubmitted: (nameCheck) {
                nameCheck = nameController.value.text;
                setState(() {
                  if (nameCheck.isNotEmpty == true) {
                    nameColor = Colors.white;
                  } else {
                    nameColor = Colors.red;
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
          ///////// Name TextField End

          //Label
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
          ///////// Email TextField Start
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
          ///////// Email TextField End
          ///////// Label
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
          ///////// Password TextField Start
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
          ///////// Password TextField End
          ///////// Label
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
            child: Text(
              " Confirm Password",
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          ///////// Confirm Password TextField Start

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
              controller: confirmPassController,
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
              onFieldSubmitted: (passConCheck) {
                passConCheck = confirmPassController.value.text;
                String passCheck = passwordController.value.text;
                setState(() {
                  if (passConCheck == passCheck) {
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
          ///////// Confirm Password TextField End
          //////// Signup Button Start
          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                onPressed: signUp,
                child: Text(
                  "Sign Up",
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
          //////// Signup Button Start
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Already a User? Log in",
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future signUp() async {
    bool validSignUp = false;

    if ((confirmPassController.text == passwordController.text) &&
        (passwordController.text.length >= 8) &&
        nameController.text.isNotEmpty &&
        emailController.text.length > 8) {
      validSignUp = true;
    }
    if (validSignUp) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        User? user = result.user;
        FirebaseFirestore.instance
            .collection('users')
            .add({'userID': user!.uid, 'name': nameController.text.trim()});

        Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String error = e.message.toString();
            return AlertDialog(
              title: Text(error),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("OK"),
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
    }
  }
}
