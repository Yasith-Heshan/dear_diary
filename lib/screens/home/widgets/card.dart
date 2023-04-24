import 'package:dear_diary/models/diary_card.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;

  const CardWidget({super.key, required this.title, required this.subtitle, required this.description});


  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  String showingDesc = '';
  bool showMoreVisibility = false;
  String buttonText = 'Show More';


  @override
  Widget build(BuildContext context) {
    showingDesc = widget.description;
    if(widget.description.length>100){
      showingDesc = widget.description.substring(0,100);
      showMoreVisibility = true;
    }

    return  Card(
        color: const Color(0xFFB0E6FDFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 20
                ),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(
                    color: Colors.grey[700]
                ),
              ),
              const SizedBox(height: 10,),
              Text(showingDesc),
              Visibility(
                  visible: showMoreVisibility,
                  child: TextButton(
                    onPressed: () async{

                      DiaryCard diaryCard = DiaryCard(title: widget.title, subtitle: widget.subtitle, description: widget.description);
                      Navigator.pushNamed(context, '/view_card',arguments: diaryCard);
                    },
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ))
            ],
          ),
        )
    );
  }
}