import 'package:dear_diary/screens/home/view_card.dart';
import 'package:dear_diary/screens/sign_in/sign_in.dart';
import 'package:dear_diary/screens/signup/sign_up_email.dart';
import 'package:dear_diary/screens/signup/sign_up_password.dart';
import 'package:dear_diary/screens/wrapper.dart';
import 'package:dear_diary/services/auth_service.dart';
import 'package:dear_diary/models/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser?>.value(
        value: AuthService().authUser,
        initialData: null,
        child: MaterialApp(routes: {
          '/': (context) => const SignIn(),
          '/sign_up_email': (context) => const SignUpEmail(),
          '/sign_up_password': (context) => const SignUpPassword(),
          '/wrapper': (context) => const Wrapper(),
          '/view_card': (context) => const ViewCard()
        }));
  }
}
