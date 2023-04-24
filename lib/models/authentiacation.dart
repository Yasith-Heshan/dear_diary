import 'auth_user.dart';

class AuthenticationResponse{
  final AuthUser? authUser;
  final String error;

  AuthenticationResponse(this.authUser, this.error);

}