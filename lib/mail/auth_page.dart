import 'package:flutter/material.dart';

import 'package:loginstudy/screens/loginIn.dart';
import 'package:loginstudy/provider/weather.dart';
import 'package:loginstudy/screens/weatherScreen.dart';
import 'package:provider/provider.dart';

import '../firebase_provider.dart';

AuthPageState pageState;

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() {
    pageState = AuthPageState();
    return pageState;
  }
}

class AuthPageState extends State<AuthPage> {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    logger.d("user: ${fp.getUser()}");
    if (fp.getUser() != null && fp.getUser().isEmailVerified == true) {
      return WeatherScreen();
    } else {
      return LoginIn();
    }
  }
}