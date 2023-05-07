import 'package:bloc/bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState.initial()) {
    on<RegistrationStatusChanged>(_onRegistrationStateChanged);
  }
}

void _onRegistrationStateChanged(RegistrationStatusChanged event, Emitter<RegisterState> emit){
  emit(
    RegisterState.emailProvided(event.email)
  );

}
