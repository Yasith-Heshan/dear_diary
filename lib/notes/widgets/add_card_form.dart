import 'package:dear_diary/authentication/bloc/sign_in/sign_in_bloc.dart';
import 'package:dear_diary/authentication/model/auth_user.dart';
import 'package:dear_diary/notes/models/note.dart';
import 'package:dear_diary/repository/notes_repository.dart';
import 'package:dear_diary/shared/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardForm extends StatefulWidget {
  const AddCardForm({super.key});

  @override
  AddCardFormState createState() {
    return AddCardFormState();
  }
}

class AddCardFormState extends State<AddCardForm> {
  final _formKey = GlobalKey<FormState>();
  final text1Controller = TextEditingController();
  final text2Controller = TextEditingController();

  @override
  void dispose() {
    text1Controller.dispose();
    text2Controller.dispose();
    super.dispose();
  }

  void clearText() {
    text1Controller.clear();
    text2Controller.clear();
  }

  bool visibility = true;
  String title = '';
  String description = '';
  String subtitle = '';

  @override
  Widget build(BuildContext context) {
    final AuthUser authUser = context.read<SignInBloc>().state.authUser!;
    String email = authUser!.email;
    subtitle = email.split('@')[0];

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              cursorColor: Colors.black,
              controller: text1Controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: noteInputDecoration,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              cursorColor: Colors.black,
              controller: text2Controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              maxLines: 5,
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              decoration: noteInputDecoration.copyWith(
                hintText: 'Enter Description'
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  NotesRepository notesRepository = NotesRepository();
                  Note note = Note(
                      title: title, subtitle: subtitle, description: description);
                  notesRepository.addNote(note);
                  clearText();
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(double.infinity, 40)),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
