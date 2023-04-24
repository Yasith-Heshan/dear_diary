import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/auth_user.dart';
import '../../../models/diary_card.dart';
import '../../../services/home_service.dart';
import 'card_list.dart';

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

  void dispose() {
    text1Controller.dispose();
    text2Controller.dispose();
    super.dispose();
  }

  void clearText(){
    text1Controller.clear();
    text2Controller.clear();
  }

  bool visibility = true;
  String title = '';
  String description = '';
  String subtitle = '';


  @override
  Widget build(BuildContext context) {

    final AuthUser? authUser = Provider.of<AuthUser?>(context);
    String email = authUser!.email;
    subtitle = email.split('@')[0];


    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: text1Controller,
              onChanged: (value){
                setState(() {
                  title=value;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  fillColor: Color(0xFF3097DAFF),
                  filled: true,
                  hintText: 'Submit New'
              ),

            ),
            const SizedBox(height: 10,),
            Visibility(
                visible: visibility,
                child: TextFormField(
                  controller: text2Controller,
                  maxLines: 5,
                  onChanged: (value){
                    setState(() {
                      description=value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      fillColor: const Color(0xFF3097DAFF),
                      filled: true,
                      hintText:'Enter Description'
                  ),
                )
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
                HomeService homeService = HomeService();
                DiaryCard diaryCard = DiaryCard(title: title, subtitle: subtitle, description: description);
                homeService.addDiaryCard(diaryCard);
                clearText();
              },
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(double.infinity, 40)
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
              ),
            ),
            const DiaryCardsList(),
          ],
        ),
      ),
    );
  }
}