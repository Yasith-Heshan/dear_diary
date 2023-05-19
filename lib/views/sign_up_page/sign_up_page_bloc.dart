import 'package:bloc/bloc.dart';
import '../../../repository/auth_repository.dart';

part 'sign_up_page_event.dart';
part 'sign_up_page_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;

  SignUpBloc()
      : _authRepository=AuthRepository(),
        super(SignUpState.initialState) {
    on<SignUpStatusChanged>(_onRegistrationStateChanged);
    on<SignUpRequested>(_onSignUpRequested);
  }


  void _onRegistrationStateChanged(SignUpStatusChanged event,
      Emitter<SignUpState> emit) {
    emit(
        state.clone(status:RegistrationStatus.emailProvided, email:event.email, error: '')
    );
  }

  Future<void> _onSignUpRequested(SignUpRequested event,
      Emitter<SignUpState> emit) async {
    emit(
        state.clone(status: RegistrationStatus.loading)
    );
    String error = await _authRepository.signUP(event.email, event.password);
    if(error!=''){
      emit(
        state.clone(status: RegistrationStatus.failed, error: error)
      );
    }else{
      emit(
        state.clone(status: RegistrationStatus.succeeded, error: '')
      );
    }
  }

}