import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../notes/models/note.dart' show Note;
import 'package:http/http.dart' as http;


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


  Stream<List<Note>> get notes async*{
    while(true){
      try{
        List<Note> notesList = await fetchNotes();
        yield notesList;
      }catch(e){
        rethrow;
      }
      await Future.delayed(const Duration(seconds: 2));
    }
  }
  
  Future<List<Note>> fetchNotes()async{
    final response = await http.get(Uri.parse(dotenv.env['REST_API_URL']!));

    if(response.statusCode == 200){
       final fetched =  jsonDecode(response.body) as List;
       final noteList =  fetched.map(
           (e)=>Note.fromJson(e)
       ).toList();

       return noteList;

    }
    else{
      throw Exception('Failed to load Notes');
    }
  }





}

