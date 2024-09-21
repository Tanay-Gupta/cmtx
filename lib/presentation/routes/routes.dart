// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../infrastructure/services/auth_services.dart';
// import '../pages/error_screen.dart';
// import '../pages/home_screen.dart';
// import '../pages/login_screen.dart';
// import '../pages/signup_screen.dart';

// class AppRoutes {
//   static const String home = '/';
//   static const String login = '/login';
//   static const String signup = '/signup';

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case home:
//         return _getHomeRoute();
//       case login:
//         return MaterialPageRoute(builder: (_) => LoginPage());
//       case signup:
//         return MaterialPageRoute(builder: (_) => SignupPage());
//       default:
//         return MaterialPageRoute(builder: (_) => ErrorPage());
//     }
//   }

//   static MaterialPageRoute _getHomeRoute() {
//     return MaterialPageRoute(
//       builder: (context) {
//         final authService = Provider.of<AuthService>(context, listen: false);
//         return authService.user != null ? HomePage() : LoginPage();
//       },
//     );
//   }
// }
