import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShowFullEmailProvider()..initialize(),
      child: Scaffold(
        appBar: AppBar(title: Text('Home Page')),
        body: Center(
          child: Consumer<ShowFullEmailProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return CircularProgressIndicator();
              }
              if (provider.user == null) {
                return Text('Not logged in');
              }

              if (provider.errorMessage != null) {
                return Text('Error: ${provider.errorMessage}');
              }

              final email = provider.showFullEmail
                  ? provider.userData['email']
                  : provider.maskEmail(provider.userData['email']);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User email: $email'),
                  Text(provider.showFullEmail
                      ? 'Full email is shown'
                      : 'Email is masked'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ShowFullEmailProvider with ChangeNotifier {
  bool _showFullEmail = false;
  bool isLoading = true;
  String? errorMessage;
  User? user;
  Map<String, dynamic> userData = {};

  bool get showFullEmail => _showFullEmail;

  // Initialization of Remote Config and user-related data
  Future<void> initialize() async {
    try {
      // Check authentication
      user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch user data from Firestore
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(user!.uid)
            .get();
        userData = userDoc.data() ?? {};

        // Fetch Remote Config value
        final remoteConfig = FirebaseRemoteConfig.instance;
        await remoteConfig.setDefaults({'show_full_email': false});
        await remoteConfig.fetchAndActivate();
        _showFullEmail = remoteConfig.getBool('show_full_email');
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Mask the email if Remote Config says so
  String maskEmail(String email) {
    var emailParts = email.split('@');
    return emailParts[0].substring(0, 3) + '****@' + emailParts[1];
  }
}
