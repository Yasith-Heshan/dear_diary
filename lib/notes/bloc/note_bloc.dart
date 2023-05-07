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
    _notesSubscription = _notesRepository.notes.listen(
            (notes)=>add(NoteFetched(notes))
    );
  }

  @override
  Future<void> close(){
    _notesSubscription.cancel();
    return super.close();
  }

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




}
