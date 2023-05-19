
import 'package:dear_diary/views/sign_up_page/sign_up_email_page_view.dart';
import 'package:dear_diary/views/sign_up_page/sign_up_page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpProvider extends BlocProvider<SignUpBloc>{
  SignUpProvider({super.key}):super(
    create: (context)=>SignUpBloc(),
    child: const SignUpEmail()
  );
}