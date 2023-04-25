import 'package:dear_diary/screens/signup/widgets/sign_up_email_form.dart';
import 'package:flutter/material.dart';

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  State<SignUpEmail> createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
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
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
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
                        const CustomForm()
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
