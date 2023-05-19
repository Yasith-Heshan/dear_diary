import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dear_diary/models/auth_user.dart';
import 'package:dear_diary/repository/auth_repository.dart';

part 'sign_in_page_state.dart';

part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  SignInBloc()
      : _authRepository = AuthRepository(),
        super(SignInState.initialState) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<SignInStarted>(_onSignInStarted);
    on<SignOutRequested>(_onSignOutRequested);
    _authenticationStatusSubscription = _authRepository.authStatus.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event,
      Emitter<SignInState> emit
      )async{
      _authRepository.signOut();
  }

  Future<void> _onSignInStarted(
      SignInStarted event, Emitter<SignInState> emit) async {
    emit(state.clone(status:AuthenticationStatus.loading));
    String error = await _authRepository.signIn(event.email, event.password);
    if (error == '') {
      emit(state.clone(status:AuthenticationStatus.authenticated,authUser:_authRepository.getCurrentUser() as AuthUser));
    } else {
      emit(
        state.clone(status:AuthenticationStatus.unauthenticated,error:error)
      );
    }
  }

  void _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event, Emitter<SignInState> emit) {

    switch (event.status) {
      case AuthenticationStatus.authenticated:
        emit(state.clone(status: AuthenticationStatus.authenticated,authUser: _authRepository.getCurrentUser() as AuthUser));
        break;
      case AuthenticationStatus.unauthenticated:
        emit(state.clone(status: AuthenticationStatus.unauthenticated));
        break;
      case AuthenticationStatus.unknown:
        emit(state.clone(status: AuthenticationStatus.unknown,
            error: ''));
        break;

      case AuthenticationStatus.loading:
        emit(
          state.clone(
              status: AuthenticationStatus.loading,
              error: ''
          )
        );
        break;
    }
  }
}
