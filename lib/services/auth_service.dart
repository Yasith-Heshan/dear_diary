import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthUser? _userFromFirebaseUser(User? user) {
    return user != null ? AuthUser(email: user.email!) : null;
  }

  Stream<AuthUser?> get authUser {
    return _auth.authStateChanges().map((User? user) {
      return _userFromFirebaseUser(user);
    });
  }

  Future<String> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (credential.user != null) {
        return '';
      }
      return 'Unexpected Error';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return 'Unexpected Error';
  }

  Future<String> signUP(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        return '';
      }
      return 'Unexpected Error';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return 'Unexpected Error';
    }
    return 'Unexpected Error';
  }

}
