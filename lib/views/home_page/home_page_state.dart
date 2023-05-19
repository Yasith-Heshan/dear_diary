part of 'home_page_bloc.dart';

enum NoteStatus { initial, loading, success, failure }

enum BatteryPercentageFetchingStatus {
  initial,
  loading,
  succeeded,
  failed,
}

class HomePageState{
  final NoteStatus noteStatus;
  final List<Note> notes;
  final int batteryPercentage;
  final BatteryPercentageFetchingStatus batteryPercentageFetchingStatus;

  final String error;

  const HomePageState(
      {required this.batteryPercentage,
      required this.batteryPercentageFetchingStatus,
      required this.noteStatus,
      required this.notes,
      required this.error});

  static HomePageState get initialState => const HomePageState(
      noteStatus: NoteStatus.initial,
      notes: <Note>[],
      batteryPercentage: 0,
      batteryPercentageFetchingStatus: BatteryPercentageFetchingStatus.initial,
      error: '');

  HomePageState clone({
    NoteStatus? noteStatus,
    List<Note>? notes,
    String? error,
    int? batteryPercentage,
    BatteryPercentageFetchingStatus? batteryPercentageFetchingStatus
  }) {
    return HomePageState(
        noteStatus: noteStatus ?? this.noteStatus,
        notes: notes ?? this.notes,
        error: error ?? this.error,
        batteryPercentage: batteryPercentage ?? this.batteryPercentage,
        batteryPercentageFetchingStatus: batteryPercentageFetchingStatus ?? this.batteryPercentageFetchingStatus);
  }
}
