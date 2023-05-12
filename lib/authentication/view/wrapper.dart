import 'package:dear_diary/authentication/authentication.dart' show SignInCubit, SignIn,SignInState;
import 'package:dear_diary/repository/auth_repository.dart';
import 'package:dear_diary/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../notes/notes.dart' show Home;

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignInCubit(
          authRepository: RepositoryProvider.of<AuthRepository>(context)),
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (BuildContext context, state) {
          switch (state.status) {
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
