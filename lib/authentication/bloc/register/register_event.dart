part of 'register_bloc.dart';

abstract class RegisterEvent {

}

class RegistrationStatusChanged extends RegisterEvent{
  final String email;

  RegistrationStatusChanged(this.email);

}