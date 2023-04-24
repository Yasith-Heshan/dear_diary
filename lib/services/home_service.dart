import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/models/diary_card.dart';
import 'package:flutter/foundation.dart';


class HomeService{
  CollectionReference diaryCardsCollection = FirebaseFirestore.instance.collection('diary_cards');
  Future<void> addDiaryCard(DiaryCard diaryCard)async {

    final dc = <String, String>{
    "title": diaryCard.title,
    "subtitle": diaryCard.subtitle,
    "description": diaryCard.description
    };

    try{
      await diaryCardsCollection.add(dc);
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
}
  List<DiaryCard> _diaryCardsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map(
        (doc)=>DiaryCard(
            title: doc.get('title'),
            subtitle: doc.get('subtitle'),
            description: doc.get('description'))
    ).toList();
  }

  Stream<List<DiaryCard>> get diaryCards{
    return diaryCardsCollection.snapshots().map(
        (snapshot)=>_diaryCardsFromSnapshot(snapshot)
    );
  }



}