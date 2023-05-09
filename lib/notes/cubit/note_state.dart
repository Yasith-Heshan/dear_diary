part of 'note_cubit.dart';

enum NoteStatus { initial, loading, success, failure }

class NoteState extends Equatable {
  final NoteStatus status;
  final List<Note> notes;
  final String error;

  const NoteState(
      {this.status = NoteStatus.initial,
      this.notes = const <Note>[],
      this.error = ''});

  NoteState copyWith({
    NoteStatus? status,
    List<Note>? notes,
    String? error,
  }) {
    return NoteState(
        status: status ?? this.status,
        notes: notes ?? this.notes,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, notes, error];
}
