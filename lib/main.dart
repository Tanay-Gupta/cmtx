import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'infrastructure/models/user.dart';
import 'infrastructure/provider/wrapper.dart';
import 'infrastructure/services/auth_services.dart';
import 'presentation/pages/home_screen.dart';
import 'presentation/pages/login_screen.dart';
import 'presentation/pages/signup_screen.dart';
import 'presentation/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData?>.value(
      value: AuthServices().user,
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        routes: {
          '/': (context) => Wrapper(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
