import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            validator: (value){
              return EmailValidator.validate(value!)? null:'Invalid email';
            },
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color:Colors.black,
                    )
                ),
                hintText: 'Email*'
            ),
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
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
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

