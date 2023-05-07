
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dear_diary/authentication/model/auth_user.dart';
import 'package:dear_diary/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';


part 'sign_in_state.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  
  final AuthRepository _authRepository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;
  
  SignInBloc({required AuthRepository authRepository}) :
        _authRepository = authRepository,
        super(const SignInState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    _authenticationStatusSubscription = _authRepository.authStatus.listen(
            (status)=>add(_AuthenticationStatusChanged(status)),
    );
  }

  @override
  Future<void> close(){
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event,
      Emitter<SignInState> emit
      ){
    switch(event.status){
      case AuthenticationStatus.authenticated:
        emit(
          SignInState.authenticated(_authRepository.getCurrentUser() as AuthUser)
        );
        break;
      case AuthenticationStatus.unauthenticated:
        emit(
          const SignInState.unauthenticated()
        );
        break;
      case AuthenticationStatus.unknown:
        emit(const SignInState.unknown());
        break;

    }
  }

}
