import 'package:dear_diary/authentication/authentication.dart' show SignInCubit;
import 'package:dear_diary/notes/notes.dart';
import 'package:dear_diary/repository/battery_repository.dart' ;
import 'package:dear_diary/repository/notes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../battery_status/battery_status.dart';

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
          style: Theme.of(context).textTheme.headlineMedium,
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
                  context.read<SignInCubit>().signOutRequested();
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                  child: Text(
                context.read<SignInCubit>().state.authUser!.email.split('@')[0],
              )),
              const PopupMenuItem(child: Divider()),
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
          create: (context) => NoteCubit(notesRepository: _notesRepository),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocProvider(
                  create: (context) => BatteryCubit(_batteryRepository)
                    ..batteryPercentageFetchingStarted(),
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
