import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import '../../../services/auth_service.dart';
import '../../../shared/decorations.dart';
import '../../signup/widgets/loading.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String email = '';
  String password = '';
  bool isActive = false;
  bool loading = false;
  String error = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: ValidationBuilder().email('Invalid Email').build(),
            decoration: authTextInputDecoration.copyWith(hintText: 'Email*'),
            onChanged: (value) {
              setState(() {
                error = "";
                email = value;
                isActive = _formKey.currentState!.validate();
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
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
                error = "";
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
            height: 20,
          ),
          ElevatedButton(
            onPressed: (isActive)
                ? () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      String errorMsg =
                          await AuthService().signIn(email, password);
                      if (errorMsg != '') {
                        setState(() {
                          loading = false;
                          error = errorMsg;
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
          const SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () async{
                if (!mounted) return;
                await Navigator.pushReplacementNamed(context, '/sign_up_email');
              },
              child: const Text('Register')),

          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
