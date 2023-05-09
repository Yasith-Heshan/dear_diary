import 'package:cloud_firestore/cloud_firestore.dart';
import '../notes/models/note.dart';


class NotesRepository{
  CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('diary_cards');

  Future<String> addNote(Note note) async {
    final dc = note.toMap();
    String error = '';
    try {
     await notesCollection.add(dc);
    } catch (e) {
      error = 'Unexpected error';
      }

      return error;
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

