import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import '../../../../shared/decorations.dart';
import '../../../../shared/widgets/loading.dart';
import 'package:dear_diary/authentication/authentication.dart';

class SignUpPasswordForm extends StatefulWidget {
  const SignUpPasswordForm({Key? key}) : super(key: key);

  @override
  State<SignUpPasswordForm> createState() => _SignUpPasswordFormState();
}

class _SignUpPasswordFormState extends State<SignUpPasswordForm> {
  String password = '';
  bool isActive = false;
  bool loading = false;
  String error = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        RegistrationStatus status = state.status;
        if (status == RegistrationStatus.succeeded) {
          if (!mounted) return;
          await Navigator.pushNamedAndRemoveUntil(
              context, '/', ModalRoute.withName('sign_up_password'));
        }else if(status == RegistrationStatus.loading){
          setState(() {
            loading = true;
          });
        }
        else if(status == RegistrationStatus.failed){
          setState(() {
            loading = false;
          });
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: ValidationBuilder()
                  .regExp(
                  RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'),
                  'Invalid Password')
                  .build(),
              obscureText: true,
              decoration: authTextInputDecoration.copyWith(
                  hintText: 'Password*'),
              onChanged: (value) {
                setState(() {
                  password = value;
                  isActive = _formKey.currentState!.validate() ? true : false;
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: (isActive)
                  ? () async {
                if (_formKey.currentState!.validate()) {
                  context.read<RegisterCubit>().signUpRequested(
                      email: context
                          .read<RegisterCubit>()
                          .state
                          .email,
                      password: password);
                }
              }
                  : null,
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: loading? const Loading():Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'CONTINUE',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'))
          ],
        ),
      ),
    );
  }
}
