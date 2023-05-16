import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dear_diary/repository/notes_repository.dart';
import 'package:equatable/equatable.dart';

import '../models/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesRepository _notesRepository;
  late StreamSubscription<List<Note>> _notesSubscription;

  NoteBloc({required notesRepository}) :_notesRepository=notesRepository,
        super(const NoteState())
  {
    on<NoteFetched>(_onNoteFetched);
    on<NoteAddingStarted>(_onNoteAddingStarted);
    // on<NoteFetchingStarted>(_onNoteFetchingStarted);
    _notesSubscription = _notesRepository.notes.listen(
            (notes) {
              return add(NoteFetched(notes));
        },
      onError: (error){
        emit(state.copyWith(status: NoteStatus.failure));
      }
    );
  }

  @override
  Future<void> close(){
    _notesSubscription.cancel();
    return super.close();
  }

  // Future<void> _onNoteFetchingStarted(NoteFetchingStarted event, Emitter<NoteState> emit)async{
  //   try{
  //     List<Note> noteList = await _notesRepository.fetchNotes();
  //     emit(state.copyWith(status: NoteStatus.success, notes: noteList));
  //   }catch(_){
  //     emit(state.copyWith(status: NoteStatus.failure));
  //   }
  // }

  void _onNoteFetched(NoteFetched event, Emitter<NoteState> emit){
    try{
      emit(
        state.copyWith(
          status: NoteStatus.success,
          notes: event.notes
        )
      );

    }catch(_){
      emit(state.copyWith(status: NoteStatus.failure));
    }
  }

  Future<void> _onNoteAddingStarted(NoteAddingStarted event, Emitter<NoteState> emit)async{
    emit(state.copyWith(status: NoteStatus.loading));
    String error = await _notesRepository.addNote(event.note);
    if(error!=''){
      emit(state.copyWith(
        notes: state.notes,
        status: NoteStatus.failure,
        error: error,
      ));
    }
  }




}
