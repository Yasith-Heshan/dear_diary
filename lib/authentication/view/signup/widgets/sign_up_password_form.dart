import 'package:dear_diary/authentication/view/signup/sign_up_email.dart';
import 'package:dear_diary/authentication/view/signup/widgets/sign_up_email_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../shared/decorations.dart';
import '../../../../shared/widgets/loading.dart';
import '../../../bloc/register/register_bloc.dart';

class SignUpPasswordForm extends StatefulWidget {
  const SignUpPasswordForm({Key? key}) : super(key: key);

  @override
  State<SignUpPasswordForm> createState() => _SignUpPasswordFormState();
}

class _SignUpPasswordFormState extends State<SignUpPasswordForm> {
  String password = '';
  bool isActive = false;
  String error = "";
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
    builder: (context, state) {
      String email = state.email;
    return Form(
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
            decoration: authTextInputDecoration.copyWith(hintText: 'Password*'),
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
          Text(
            error,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: (isActive)
                ? () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      String errorMsg =
                          await RepositoryProvider.of<AuthRepository>(context).signUP(email, password);
                      if (errorMsg != '') {
                        setState(() {
                          error = errorMsg;
                          loading = false;
                        });
                      } else {
                        if (!mounted) return;
                        await Navigator.pushNamedAndRemoveUntil(
                            context, '/',ModalRoute.withName('sign_up_password'));
                      }
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: loading
                ? const Loading()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
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
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Back'))
        ],
      ),
    );
  },
);
  }
}