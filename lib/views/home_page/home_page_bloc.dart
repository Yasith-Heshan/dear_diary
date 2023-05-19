import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dear_diary/repository/notes_repository.dart';

import '../../models/note.dart';
import '../../repository/battery_repository.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final NotesRepository _notesRepository;
  final BatteryRepository _batteryRepository;
  late StreamSubscription<List<Note>> _notesSubscription;
  late StreamSubscription _batterySubscription;

  HomePageBloc() :
        _notesRepository=NotesRepository(),
        _batteryRepository=BatteryRepository(),
        super(HomePageState.initialState)
  {
    on<NoteFetched>(_onNoteFetched);
    on<NoteAddingStarted>(_onNoteAddingStarted);
    _notesSubscription = _notesRepository.notes.listen(
            (notes)=>add(NoteFetched(notes))
    );
    on<BatteryPercentageFetchingStarted>(_onBatteryPercentageFetchingStart);
    on<BatteryPercentageFetchingFailed>(_onBatteryPercentageFetchingFailed);
    on<BatteryPercentageFetchingSucceeded>(_onBatteryPercentageFetchingSucceeded);
    _batterySubscription = Stream.periodic(const Duration(minutes: 1)).listen(
            (event) => add(BatteryPercentageFetchingStarted())
    );
  }

  @override
  Future<void> close(){
    _notesSubscription.cancel();
    _batterySubscription.cancel();
    return super.close();
  }



  void _onNoteFetched(NoteFetched event, Emitter<HomePageState> emit){
    try{
      emit(state.clone(noteStatus: NoteStatus.loading));
      emit(
        state.clone(
            noteStatus: NoteStatus.success,
          notes: event.notes
        )
      );
    }catch(_){
      emit(state.clone(noteStatus: NoteStatus.failure));
    }
  }

  Future<void> _onNoteAddingStarted(NoteAddingStarted event, Emitter<HomePageState> emit)async{
    emit(state.clone(noteStatus: NoteStatus.loading));
    String error = await _notesRepository.addNote(event.note);
    if(error!=''){
      emit(state.clone(
        notes: state.notes,
        noteStatus: NoteStatus.failure,
        error: error,
      ));
    }
  }

  Future<void> _onBatteryPercentageFetchingStart(
      BatteryPercentageFetchingStarted event,
      Emitter<HomePageState> emit) async {
    final int batteryPercentage = await _batteryRepository.getBatteryLevel();
    if(batteryPercentage==-1){
      add(BatteryPercentageFetchingFailed(error: 'Unexpected Error'));
    }else{
      add(BatteryPercentageFetchingSucceeded(batteryPercentage: batteryPercentage, batteryPercentageFetchingStatus: BatteryPercentageFetchingStatus.succeeded));
    }
  }

  void _onBatteryPercentageFetchingSucceeded(
      BatteryPercentageFetchingSucceeded event,
      Emitter<HomePageState> emit
      ){
    emit(state.clone(error: '', batteryPercentage: event.batteryPercentage, batteryPercentageFetchingStatus: BatteryPercentageFetchingStatus.succeeded));
  }

  void _onBatteryPercentageFetchingFailed(
      BatteryPercentageFetchingFailed event,
      Emitter<HomePageState> emit
      ){
    emit(state.clone(error: event.error, batteryPercentage: 0, batteryPercentageFetchingStatus: BatteryPercentageFetchingStatus.failed));
  }






}
