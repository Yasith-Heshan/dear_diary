import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dear_diary/authentication/model/auth_user.dart';
import 'package:dear_diary/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  SignInCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignInState.unknown()) {
    _authenticationStatusSubscription =
        _authRepository.authStatus.listen((status) {
      authenticationStatusChanged(status);
    });
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> signOutRequested() async {
    _authRepository.signOut();
  }

  Future<void> signInStarted(
      {required String email, required String password}) async {
    emit(const SignInState.loading());
    String error = await _authRepository.signIn(email, password);
    if (error == '') {
      emit(SignInState.authenticated(
          _authRepository.getCurrentUser() as AuthUser));
    } else {
      emit(SignInState.failed(error));
    }
  }

  void authenticationStatusChanged(AuthenticationStatus status) {
    switch (status) {
      case AuthenticationStatus.authenticated:
        emit(SignInState.authenticated(
            _authRepository.getCurrentUser() as AuthUser));
        break;
      case AuthenticationStatus.unauthenticated:
        emit(const SignInState.unauthenticated());
        break;
      case AuthenticationStatus.unknown:
        emit(const SignInState.unknown());
        break;

      case AuthenticationStatus.loading:
        emit(
          const SignInState.unknown(),
        );
        break;
    }
  }
}
