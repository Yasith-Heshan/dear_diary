part of 'register_bloc.dart';

enum RegistrationStatus { initial, emailProvided }

class RegisterState {
  final RegistrationStatus status;
  final String email;

  const RegisterState._(
      {this.status = RegistrationStatus.initial, this.email = ''});

  const RegisterState.initial() : this._();
  const RegisterState.emailProvided(String email):
      this._(status: RegistrationStatus.emailProvided, email: email);
}
