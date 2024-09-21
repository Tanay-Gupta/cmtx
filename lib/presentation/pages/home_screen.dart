// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ShowFullEmailProvider()..initialize(),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Home Page')),
//         body: Center(
//           child: Consumer<ShowFullEmailProvider>(
//             builder: (context, provider, _) {
//               if (provider.isLoading) {
//                 return CircularProgressIndicator();
//               }
//               if (provider.user == null) {
//                 return Text('Not logged in');
//               }

//               if (provider.errorMessage != null) {
//                 return Text('Error: ${provider.errorMessage}');
//               }

//               final email = provider.showFullEmail
//                   ? provider.userData['email']
//                   : provider.maskEmail(provider.userData['email']);

//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('User email: $email'),
//                   Text(provider.showFullEmail
//                       ? 'Full email is shown'
//                       : 'Email is masked'),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ShowFullEmailProvider with ChangeNotifier {
//   bool _showFullEmail = false;
//   bool isLoading = true;
//   String? errorMessage;
//   User? user;
//   Map<String, dynamic> userData = {};

//   bool get showFullEmail => _showFullEmail;

//   // Initialization of Remote Config and user-related data
//   Future<void> initialize() async {
//     try {
//       // Check authentication
//       user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         // Fetch user data from Firestore
//         DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
//             .instance
//             .collection('users')
//             .doc(user!.uid)
//             .get();
//         userData = userDoc.data() ?? {};

//         // Fetch Remote Config value
//         final remoteConfig = FirebaseRemoteConfig.instance;
//         await remoteConfig.setDefaults({'show_full_email': false});
//         await remoteConfig.fetchAndActivate();
//         _showFullEmail = remoteConfig.getBool('show_full_email');
//       }
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Mask the email if Remote Config says so
//   String maskEmail(String email) {
//     var emailParts = email.split('@');
//     return emailParts[0].substring(0, 3) + '****@' + emailParts[1];
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../infrastructure/models/post_model.dart';
import '../../infrastructure/services/api_services.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShowFullEmailProvider(),
      child: Consumer<ShowFullEmailProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Comments List'),
            ),
            body: FutureBuilder<List<PostModel>>(
              future: ApiService().fetchComments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<PostModel>? comments = snapshot.data;

                  if (comments == null || comments.isEmpty) {
                    return Center(child: Text('No comments found'));
                  }

                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return CommentCard(
                        name: comment.name ?? 'No Name',
                        email: comment.email ?? 'No Email',
                        body: comment.body ?? 'No Body',
                        showFullEmail: provider.showFullEmail,
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No comments found'));
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final String name;
  final String email;
  final String body;
  final bool showFullEmail;

  const CommentCard({
    Key? key,
    required this.name,
    required this.email,
    required this.body,
    required this.showFullEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Function to mask the email based on the showFullEmail flag
    String getMaskedEmail(String email) {
      if (showFullEmail) {
        return email;
      } else {
        final emailParts = email.split('@');
        final namePart = emailParts[0];
        final maskedName =
            namePart.length > 3 ? '${namePart.substring(0, 3)}****' : '****';
        return '$maskedName@${emailParts[1]}';
      }
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${getMaskedEmail(email)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Comment: $body',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowFullEmailProvider with ChangeNotifier {
  bool _showFullEmail = false;

  bool get showFullEmail => _showFullEmail;

  void setShowFullEmail(bool value) {
    _showFullEmail = value;
    notifyListeners();
  }
}
