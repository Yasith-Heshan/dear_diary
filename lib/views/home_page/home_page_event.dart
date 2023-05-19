part of 'home_page_bloc.dart';


abstract class HomePageEvent {}

class NoteFetched extends HomePageEvent{
  final List<Note> notes;
  NoteFetched(this.notes);
}

class NoteAddingStarted extends HomePageEvent{
  final Note note;
  NoteAddingStarted({required this.note});
}

class NoteAddingFailed extends HomePageEvent{
  final String error;
  NoteAddingFailed({required this.error});
}


class BatteryStateChanged extends HomePageEvent{
  final int batteryPercentage;
  final BatteryPercentageFetchingStatus batteryPercentageFetchingStatus;
  final String error;

  BatteryStateChanged(
      {required this.batteryPercentage,
        required this.batteryPercentageFetchingStatus,
        required this.error});
}

class BatteryPercentageFetchingStarted extends HomePageEvent{}

class BatteryPercentageFetchingSucceeded extends HomePageEvent{
  final int batteryPercentage;
  final BatteryPercentageFetchingStatus batteryPercentageFetchingStatus;

  BatteryPercentageFetchingSucceeded(
      {required this.batteryPercentage, required this.batteryPercentageFetchingStatus});

}

class BatteryPercentageFetchingFailed extends HomePageEvent{
  final String error;

  BatteryPercentageFetchingFailed({required this.error});

}


