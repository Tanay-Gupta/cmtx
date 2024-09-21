import 'package:cmtx/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/pages/home_screen.dart';
import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);

    if (user == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}