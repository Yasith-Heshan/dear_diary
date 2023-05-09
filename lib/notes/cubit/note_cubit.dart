import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dear_diary/repository/notes_repository.dart';
import 'package:equatable/equatable.dart';

import '../models/note.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NotesRepository _notesRepository;
  late StreamSubscription<List<Note>> _notesSubscription;

  NoteCubit({required notesRepository})
      : _notesRepository = notesRepository,
        super(const NoteState()) {
    _notesSubscription = _notesRepository.notes.listen((notes) {
      noteFetched(notes);
    });
  }

  @override
  Future<void> close() {
    _notesSubscription.cancel();
    return super.close();
  }

  void noteFetched(List<Note> notes) {
    try {
      emit(state.copyWith(status: NoteStatus.success, notes: notes));
    } catch (_) {
      emit(state.copyWith(status: NoteStatus.failure));
    }
  }

  Future<void> noteAddingStarted({required Note note}) async {
    emit(state.copyWith(status: NoteStatus.loading));
    String error = await _notesRepository.addNote(note);
    if (error != '') {
      emit(state.copyWith(
        notes: state.notes,
        status: NoteStatus.failure,
        error: error,
      ));
    }
  }
}
