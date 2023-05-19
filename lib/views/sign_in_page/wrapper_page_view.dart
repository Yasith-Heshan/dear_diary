import 'package:dear_diary/repository/auth_repository.dart';
import 'package:dear_diary/shared/widgets/loading.dart';
import 'package:dear_diary/views/sign_in_page/sign_in_page_bloc.dart';
import 'package:dear_diary/views/sign_in_page/sign_in_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_page/home_page_view.dart';



class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc,SignInState>(
      buildWhen: (previous,current){
        return previous.status!=current.status;
      },
      builder: (BuildContext context, state) {
        switch(state.status){
          case AuthenticationStatus.unknown:
            return const SignIn();
          case AuthenticationStatus.authenticated:
            return const Home();
          case AuthenticationStatus.unauthenticated:
            return const SignIn();
          case AuthenticationStatus.loading:
            return const Loading();
        }
      },
    );
  }
}
