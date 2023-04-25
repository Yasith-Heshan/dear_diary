import 'package:dear_diary/models/diary_card.dart';
import 'package:dear_diary/services/home_service.dart';
import 'package:flutter/material.dart';
import 'card.dart';

class DiaryCardsList extends StatefulWidget {
  const DiaryCardsList({Key? key}) : super(key: key);

  @override
  State<DiaryCardsList> createState() => _DiaryCardsListState();
}

class _DiaryCardsListState extends State<DiaryCardsList> {
  List<CardWidget> diaryCards = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DiaryCard>>(
        stream: HomeService().diaryCards,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            diaryCards = snapshot.data!
                .map((diaryCard) => CardWidget(
                    title: diaryCard.title,
                    subtitle: diaryCard.subtitle,
                    description: diaryCard.description))
                .toList();
          }
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: diaryCards,
          );
        });
  }
}
