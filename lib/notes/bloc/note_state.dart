part of 'note_bloc.dart';

enum NoteStatus { initial, success, failure }

class NoteState extends Equatable {
  final NoteStatus status;
  final List<Note> notes;

  const NoteState({
    this.status = NoteStatus.initial,
    this.notes = const <Note>[],
  });

  NoteState copyWith({
    NoteStatus? status,
    List<Note>? notes,
  }) {
    return NoteState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, notes];
}

