import 'package:dear_diary/models/diary_card.dart';
import 'package:flutter/material.dart';

class ViewCard extends StatelessWidget {
  const ViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    DiaryCard diaryCard =
        ModalRoute.of(context)!.settings.arguments as DiaryCard;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text(diaryCard.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Color(0xA5CFE6FF),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diaryCard.subtitle,
                      style: TextStyle(
                          color: Colors.grey[700],
                        fontSize: 20
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        diaryCard.description,
                      style: const TextStyle(
                        fontSize: 18
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
