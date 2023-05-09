part of 'register_bloc.dart';

abstract class RegisterEvent {

}

class RegistrationStatusChanged extends RegisterEvent{
  final String email;

  RegistrationStatusChanged(this.email);

}

class SignUpRequested extends RegisterEvent{
  final String email;
  final String password;

  SignUpRequested({required this.email, required this.password});


}