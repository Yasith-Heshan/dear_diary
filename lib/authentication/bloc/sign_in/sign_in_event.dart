part of 'sign_in_bloc.dart';

class SignInEvent {
  const SignInEvent();
}

class _AuthenticationStatusChanged extends SignInEvent{
  final AuthenticationStatus status;

  const _AuthenticationStatusChanged(this.status);
}

class LogoutRequested extends SignInEvent{}