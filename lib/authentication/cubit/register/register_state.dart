part of 'register_cubit.dart';

enum RegistrationStatus { initial, emailProvided, loading,succeeded, failed }

class RegisterState {
  final RegistrationStatus status;
  final String email;
  final String error;

  const RegisterState._(
      {this.status = RegistrationStatus.initial, this.email = '', this.error=''});

  const RegisterState.initial() : this._();

  const RegisterState.emailProvided(String email)
      : this._(status: RegistrationStatus.emailProvided, email: email,error: '');

  const RegisterState.loading() : this._(status: RegistrationStatus.loading);
  const RegisterState.failed(String error) : this._(status: RegistrationStatus.failed, error: error);
  const RegisterState.succeeded() : this._(status: RegistrationStatus.succeeded, error: '');
}
