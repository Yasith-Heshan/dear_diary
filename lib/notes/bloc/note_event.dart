part of 'note_bloc.dart';


abstract class NoteEvent {}

class NoteFetched extends NoteEvent{
  final List<Note> notes;

  NoteFetched(this.notes);

}

class NoteAddingStarted extends NoteEvent{
  final Note note;
  NoteAddingStarted({required this.note});
}

class NoteAddingFailed extends NoteEvent{
  final String error;

  NoteAddingFailed({required this.error});


}


