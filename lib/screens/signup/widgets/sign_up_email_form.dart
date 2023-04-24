import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import '../../../shared/decorations.dart';
class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  String? email;
  bool isActive=false;
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
            onChanged: (value){

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
            onPressed: (isActive)?(){
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pushReplacementNamed('/sign_up_password',arguments: email);
              }
            }:null,
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('CONTINUE',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  SizedBox(width: 5,),
                  Icon(Icons.arrow_forward,),
                ],
              ),
            ),
          ),
          TextButton(
              onPressed: ()async{
                await Navigator.pushReplacementNamed(context,'/');
              },
              child: const Text('Back'))
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}