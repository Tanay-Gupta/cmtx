import 'package:flutter/material.dart';
import '../../infrastructure/models/post_model.dart';
import '../../infrastructure/services/api_services.dart';
import '../../infrastructure/services/auth_services.dart';
import '../../values/colors.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:lottie/lottie.dart';
import 'package:collection/collection.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showFullEmail = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      setState(() {
        _showFullEmail = remoteConfig.getBool('show_full_email');
      });
    });
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhereOrNull(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
    });
  }

  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      //-----------------------------app bar--------------------------
      appBar: AppBar(
        backgroundColor: AppColors.appBarTitleAndButtonColor,
        title: const Text(
          'Comments',
          style: TextStyle(
            color: AppColors.backgroundColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          //-----------------------------Log out --------------------------
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: AppColors.backgroundColor,
            ),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      //-----------------------------body--------------------------
      body: FutureBuilder<List<PostModel>>(
        future: ApiService().fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/animations/Animation - 1726943528990.json',
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Lottie.asset(
                'assets/animations/Animation - 1726943830106.json',
              ),
            );
          } else if (snapshot.hasData) {
            List<PostModel>? comments = snapshot.data;

            if (comments == null || comments.isEmpty) {
              return const Center(child: Text('No comment found'));
            }

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return CommentCard(
                    name: comment.name ?? 'No Name',
                    email: comment.email ?? 'No Email',
                    body: comment.body ?? 'No Body',
                    showFullEmail: _showFullEmail,
                  );
                },
              ),
            );
          } else {
            return Center(
                child: Center(
                    child: Lottie.asset(
              'assets/animations/Animation - 1726943830106.json',
            )));
          }
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
    super.key,
    required this.name,
    required this.email,
    required this.body,
    required this.showFullEmail,
  });

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0F575C8A),
              blurRadius: 35,
              offset: Offset(0, 10),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //-----------------------------first letter of name--------------------------
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: const BoxDecoration(
                    color: AppColors.contactIconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      name[0].toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                //-----------------------------name and email--------------------------

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Name: ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13.0,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TextSpan(
                                text: name,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Email: ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13.0,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TextSpan(
                                text: getMaskedEmail(email),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          body,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                            color: Colors.black,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
