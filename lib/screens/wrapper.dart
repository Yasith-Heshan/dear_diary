import 'package:dear_diary/screens/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth_user.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthUser? authUser = Provider.of<AuthUser?>(context);
    if (authUser == null) {
      return const SignIn();
    } else {
      return const Home();
    }
  }
}
