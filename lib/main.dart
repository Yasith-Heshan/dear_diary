import 'package:dear_diary/notes/view/view_card.dart';
import 'package:dear_diary/repository/auth_repository.dart';
import 'package:dear_diary/authentication/view/wrapper.dart';
import 'package:dear_diary/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication/view/signup/sign_up_email.dart';
import 'authentication/view/signup/sign_up_password.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp(routes: {
            '/': (context) => const Wrapper(),
            '/sign_up_email': (context) => const SignUpEmail(),
            '/sign_up_password': (context) => const SignUpPassword(),
            '/view_card': (context) => const ViewCard()
          },
          theme: AppTheme.lightTheme
          ),
        ),
      ),
    );
  }
}
