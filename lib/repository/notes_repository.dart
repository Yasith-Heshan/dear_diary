import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dear_diary/notes/bloc/note_bloc.dart';
import 'package:flutter/foundation.dart';

import '../notes/models/note.dart';


class NotesRepository{
  CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('diary_cards');

  Future<void> addNote(Note note) async {
    final dc = note.toMap();

    try {
      await notesCollection.add(dc);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      }
    }


  List<Note> _notesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Note.fromDoc(doc))
        .toList();
  }

  Stream<List<Note>> get notes {
    return notesCollection
        .snapshots()
        .map((snapshot) => _notesFromSnapshot(snapshot));
  }

}

