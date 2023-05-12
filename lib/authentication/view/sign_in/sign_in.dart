import 'package:dear_diary/authentication/authentication.dart' show SignInForm;
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                   Text(
                    'Dear Diary',
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                    child: Column(
                      children: [
                        Text(
                          'Sign In',
                          style:Theme.of(context).textTheme.headlineLarge
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SignInForm(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
