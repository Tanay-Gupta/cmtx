import 'package:flutter/material.dart';
import '../../infrastructure/provider/wrapper.dart';

import '../pages/home_screen.dart';
import '../pages/login_screen.dart';
import '../pages/signup_screen.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => Wrapper(),
    '/login': (context) => LoginPage(),
    '/signup': (context) => SignupPage(),
    '/home': (context) => HomePage(),
  };
}
