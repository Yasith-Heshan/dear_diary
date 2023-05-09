part of 'sign_in_cubit.dart';


class SignInState extends Equatable {
  final AuthenticationStatus status;
  final AuthUser? authUser;
  final String error;

  const SignInState._({
    this.status = AuthenticationStatus.unknown,
    this.authUser,
    this.error = '',
  });

  const SignInState.unknown(): this._();
  const SignInState.loading(): this._(status: AuthenticationStatus.loading);
  const SignInState.authenticated(AuthUser authUser):
      this._(status: AuthenticationStatus.authenticated, authUser:authUser);
  const SignInState.unauthenticated():
      this._(status: AuthenticationStatus.unauthenticated);
  const SignInState.failed(String error):
      this._(status: AuthenticationStatus.unauthenticated, error: error);

  @override
  List<Object?> get props => [status,authUser];
}

