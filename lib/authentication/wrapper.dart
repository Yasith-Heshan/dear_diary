import 'package:dear_diary/authentication/bloc/sign_in/sign_in_bloc.dart';
import 'package:dear_diary/authentication/view/sign_in/sign_in.dart';
import 'package:dear_diary/repository/auth_repository.dart';
import 'package:dear_diary/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../notes/view/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>SignInBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: BlocBuilder<SignInBloc,SignInState>(

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
        ),
    );
  }
}
