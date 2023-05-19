part of 'sign_in_page_bloc.dart';


class SignInState {
  final AuthenticationStatus status;
  final AuthUser? authUser;
  final String error;

  const SignInState({required this.status, this.authUser, required this.error});

  static SignInState get initialState=>const SignInState(
      status: AuthenticationStatus.unknown,
      error: ''
  );

  SignInState clone(
      {AuthenticationStatus? status, AuthUser? authUser, String? error}){
    return SignInState(
        status: status ?? this.status,
        authUser: authUser?? this.authUser,
        error: error ?? this.error,
    );
  }
}

/*
this.status = AuthenticationStatus.unknown,
    this.authUser,
    this.error = '',
* unknown = (status = AuthenticationStatus.unknown)
* loading = (status: AuthenticationStatus.loading)
* authenticated = (status: AuthenticationStatus.authenticated, authUser:authUser)
* unauthenticated = (status: AuthenticationStatus.unauthenticated)
* faild = (status: AuthenticationStatus.unauthenticated, error: error)
*/