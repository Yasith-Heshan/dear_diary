import 'package:dear_diary/views/sign_in_page/sign_in_page_bloc.dart';
import 'package:dear_diary/views/sign_in_page/wrapper_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignInBlocProvider extends BlocProvider<SignInBloc>{
  SignInBlocProvider({super.key}):super(
  create: (BuildContext context)=>SignInBloc(),
  child: const Wrapper(),
  );
}


