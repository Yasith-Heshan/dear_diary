import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/auth_repository.dart';
import 'package:dear_diary/authentication/authentication.dart' show RegisterCubit,SignUpEmailForm;

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  State<SignUpEmail> createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterCubit(RepositoryProvider.of<AuthRepository>(context)),
      child: Scaffold(
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
                    Text('Dear Diary',
                        style: Theme.of(context).textTheme.bodyLarge),
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
                          Text('Sign Up',
                              style: Theme.of(context).textTheme.headlineLarge),
                          const SizedBox(
                            height: 40,
                          ),
                          const SignUpEmailForm()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
