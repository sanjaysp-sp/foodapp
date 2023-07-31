import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/loginpage/signin_page.dart';

import '../const/themeColor.dart';
import '../constant/themeColor.dart';


final FirebaseAuth mAuth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  bool _toggleVisibility = true;

  bool _toggleConfirmVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(45),
              width: 330,
              decoration: new BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: new AssetImage(
                    'assets/food.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password more than 6",
                        hintStyle: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 18.0,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _toggleVisibility = !_toggleVisibility;
                            });
                          },
                          icon: _toggleVisibility
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: _toggleVisibility,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 18.0,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _toggleConfirmVisibility =
                              !_toggleConfirmVisibility;
                            });
                          },
                          icon: _toggleConfirmVisibility
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: _toggleConfirmVisibility,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
                child: Container(
                  height: 50.0,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Themes.color,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(blurRadius: 2, color: Themes.color)
                      ]),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  // Check if passwords match
                  if (passwordController.text == confirmPasswordController.text) {
                    // Passwords match, proceed with sign-up
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    )
                        .then((signedInUser) {
                      // User created successfully
                      Fluttertoast.showToast(
                        msg: 'Sign-up successful',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                      );

                      // Redirect to sign-in page
                      Navigator.pushReplacementNamed(context, '/signin');
                    })
                        .catchError((e) {
                      // Handle sign-up error
                      print(e);
                    });
                  } else {
                    // Passwords do not match
                    // Display an error message or handle accordingly
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Password Mismatch'),
                          content: Text('Please make sure the passwords match.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
            ),
            Divider(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account?",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
                ),
                SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SignInPage()));
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}