import 'package:dear_diary/screens/signup/widgets/sign_up_password_form.dart';
import 'package:flutter/material.dart';

class SignUpPassword extends StatefulWidget {
  const SignUpPassword({Key? key}) : super(key: key);

  @override
  State<SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: SingleChildScrollView(
            reverse: false,
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
                  const Text(
                    'Dear Diary',
                    style: TextStyle(color: Colors.white, fontSize: 17),
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
                          'Sign Up',
                          style:
                              TextStyle(fontSize: 35, color: Colors.blue[700]),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const SignUpPasswordForm()
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
