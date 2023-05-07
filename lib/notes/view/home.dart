import 'package:dear_diary/notes/bloc/note_bloc.dart';
import 'package:dear_diary/repository/battery_repository.dart';
import 'package:dear_diary/repository/notes_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../battery_status/bloc/battery_bloc.dart';
import '../widgets/add_card_form.dart';
import '../widgets/battery_status.dart';
import '../widgets/card_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final NotesRepository _notesRepository;
  late final BatteryRepository _batteryRepository;


  @override
  void initState() {
    super.initState();
    _notesRepository = NotesRepository();
    _batteryRepository = BatteryRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            onSelected: (String result) async {
              switch (result) {
                case 'sign_out':
                  await FirebaseAuth.instance.signOut();
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'sign_out',
                child: Text('Sign Out'),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: RepositoryProvider.value(
        value: _notesRepository,
        child: BlocProvider(
          create: (context) =>
              NoteBloc(notesRepository: _notesRepository),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocProvider(
                  create: (context) =>
                  BatteryBloc(_batteryRepository)
                    ..add(BatteryPercentageFetchingStarted()),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: BatteryStatus(),
                  ),
                ),
                const AddCardForm(),
                const DiaryCardsList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
