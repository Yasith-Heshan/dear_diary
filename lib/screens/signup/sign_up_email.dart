import 'package:dear_diary/shared/decorations.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  State<SignUpEmail> createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Image.asset(
                        'assets/logo.png',
                      width: 30,
                    ),
                    const SizedBox(width: 10.0,),
                    const Text(
                        'Dear Diary',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                      ),
                    ),]
                ),
                const SizedBox(height: 20,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                    child: Column(
                      children: [
                        Text(
                            'Sign Up',
                          style: TextStyle(
                            fontSize: 35,
                              color: Colors.blue[700]
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      const CustomForm()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
                Navigator.of(context).pushNamed('/sign_up_password',arguments: email);
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

          )
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}

