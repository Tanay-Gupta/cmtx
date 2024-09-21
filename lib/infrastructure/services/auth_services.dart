import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // create userdata obj based on firebase user
  UserData? _userFromFirebaseUser(User? user) {
    return user != null ? UserData(uid: user.uid, email: user.email) : null;
  }
//auth change user stream

  Stream<UserData?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future RegisterWithEmailAndPassword(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      // Store user information in Firestore after successful registration
      await _firestore.collection('users').doc(result.user!.uid).set({
        'name': name,
        'email': email,
      });

      return (_userFromFirebaseUser(user));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signIn with email and password

  Future SignInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      print(user);

      return (_userFromFirebaseUser(user));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
