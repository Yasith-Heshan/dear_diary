part of 'sign_up_page_bloc.dart';

enum RegistrationStatus { initial, emailProvided, loading,succeeded, failed }

class SignUpState {
  final RegistrationStatus status;
  final String email;
  final String error;

  SignUpState({required this.status, required this.email, required this.error});

  static SignUpState get initialState=>SignUpState(
      status: RegistrationStatus.initial,
      email: '',
      error: ''
  );

  SignUpState clone(
      {RegistrationStatus? status, String? email, String? error}){
    return SignUpState(
        status: status?? this.status,
        email: email?? this.email,
        error: error ?? this.error
    );
  }

}
