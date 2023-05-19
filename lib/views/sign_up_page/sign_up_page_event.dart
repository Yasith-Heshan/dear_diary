part of 'sign_up_page_bloc.dart';

abstract class SignUpEvent {

}

class SignUpStatusChanged extends SignUpEvent{
  final String email;

  SignUpStatusChanged(this.email);

}

class SignUpRequested extends SignUpEvent{
  final String email;
  final String password;

  SignUpRequested({required this.email, required this.password});


}