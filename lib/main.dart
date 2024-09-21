import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'routes.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Firestore Example',
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.login: (context) => LoginPage(),
        AppRoutes.signup: (context) => SignupPage(),
      },
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
