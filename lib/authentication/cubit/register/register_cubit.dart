import 'package:bloc/bloc.dart';

import '../../../repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(const RegisterState.initial());

  void registrationStatusChanged(String email) {
    emit(RegisterState.emailProvided(email));
  }

  Future<void> signUpRequested(
      {required String email, required String password}) async {
    emit(const RegisterState.loading());
    String error = await _authRepository.signUP(email, password);
    if (error != '') {
      emit(RegisterState.failed(error));
    } else {
      emit(const RegisterState.succeeded());
    }
  }
}
