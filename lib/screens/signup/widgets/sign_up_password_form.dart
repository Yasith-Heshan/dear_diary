import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import '../../../services/auth_service.dart';
import '../../../shared/decorations.dart';
import 'loading.dart';

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
    String email = ModalRoute.of(context)!.settings.arguments as String;
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
                          await AuthService().signUP(email, password);
                      if (errorMsg != '') {
                        setState(() {
                          error = errorMsg;
                          loading = false;
                        });
                      } else {
                        if (!mounted) return;
                        await Navigator.pushReplacementNamed(
                            context, '/wrapper');
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
              onPressed: () async {
                await Navigator.pushReplacementNamed(context, '/sign_up_email');
              },
              child: const Text('Back'))
        ],
      ),
    );
  }
}
