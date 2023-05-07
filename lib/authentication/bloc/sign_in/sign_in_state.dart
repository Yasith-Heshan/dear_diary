part of 'sign_in_bloc.dart';


class SignInState extends Equatable {
  final AuthenticationStatus status;
  final AuthUser? authUser;

  const SignInState._({
    this.status = AuthenticationStatus.unknown,
    this.authUser,
  });

  const SignInState.unknown(): this._();
  const SignInState.authenticated(AuthUser authUser):
      this._(status: AuthenticationStatus.authenticated, authUser:authUser);
  const SignInState.unauthenticated():
      this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status,authUser];
}

