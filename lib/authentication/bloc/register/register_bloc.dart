import 'package:bloc/bloc.dart';

import '../../../repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc(AuthRepository authRepository)
      : _authRepository=authRepository,
        super(const RegisterState.initial()) {
    on<RegistrationStatusChanged>(_onRegistrationStateChanged);
    on<SignUpRequested>(_onSignUpRequested);
  }


  void _onRegistrationStateChanged(RegistrationStatusChanged event,
      Emitter<RegisterState> emit) {
    emit(
        RegisterState.emailProvided(event.email)
    );
  }

  Future<void> _onSignUpRequested(SignUpRequested event,
      Emitter<RegisterState> emit) async {
    emit(
        const RegisterState.loading()
    );
    String error = await _authRepository.signUP(event.email, event.password);
    if(error!=''){
      emit(RegisterState.failed(error));
    }else{
      emit(const RegisterState.succeeded());
    }
  }

}