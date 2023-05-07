import 'package:dear_diary/authentication/bloc/register/register_bloc.dart';
import 'package:dear_diary/authentication/view/signup/sign_up_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../../../../shared/decorations.dart';


class SignUpEmailForm extends StatefulWidget {
  const SignUpEmailForm({Key? key}) : super(key: key);

  @override
  State<SignUpEmailForm> createState() => _SignUpEmailFormState();
}

class _SignUpEmailFormState extends State<SignUpEmailForm> {
  String? email='';
  bool isActive = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: context.read<RegisterBloc>().state.email,
              validator: ValidationBuilder().email('Invalid Email').build(),
              decoration: authTextInputDecoration.copyWith(hintText: 'Email*'),
              onChanged: (value) {
                setState(() {
                  email = value;
                  isActive = _formKey.currentState!.validate();
                });
              },
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: (isActive)
                  ? () {
                if (_formKey.currentState!.validate()) {
                  context.read<RegisterBloc>().add(RegistrationStatusChanged(email!));
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_)=>BlocProvider.value(
                      value: BlocProvider.of<RegisterBloc>(context),
                      child: const SignUpPassword(),
                    )
                    )
                  );

                }
              }
                  : null,
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: Padding(
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
                  await Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text('Back'))
            // Add TextFormFields and ElevatedButton here.
          ],
        ),
      );
  }
}
