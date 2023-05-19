part of 'sign_in_page_bloc.dart';

class SignInEvent {
  const SignInEvent();
}

class _AuthenticationStatusChanged extends SignInEvent{
  final AuthenticationStatus status;

  const _AuthenticationStatusChanged(this.status);
}
class SignInStarted extends SignInEvent{
  final String email;
  final String password;

  SignInStarted({required this.email, required this.password});

}
class SignOutRequested extends SignInEvent{}