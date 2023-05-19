import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widgets/loading.dart';
import '../home_page_bloc.dart';
import 'card.dart';

class DiaryCardsList extends StatefulWidget {


  const DiaryCardsList({super.key});

  @override
  State<DiaryCardsList> createState() => _DiaryCardsListState();
}

class _DiaryCardsListState extends State<DiaryCardsList> {
  List<CardWidget> diaryCards = [];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc,HomePageState>(
        buildWhen: (previous,current){
          return previous.noteStatus!=current.noteStatus;
        },
        builder: (context,state){
          switch(state.noteStatus){
            case NoteStatus.initial:
              return const Center(
                child: Loading(),
              );

            case NoteStatus.success:
              diaryCards = state.notes.map(
                  (note)=>CardWidget(title: note.title, subtitle: note.subtitle, description: note.description)
              ).toList();
              return Container(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: diaryCards.cast(),
                  ),
                );
            case NoteStatus.failure:
              return const Center(
                child: Text('failed to fetch Notes'),
              );
            case NoteStatus.loading:
              return const Center(
                child: Loading(),
              );
          }
        }

    );
  }
}
