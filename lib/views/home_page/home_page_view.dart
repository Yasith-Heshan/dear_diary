import 'package:dear_diary/repository/battery_repository.dart';
import 'package:dear_diary/repository/notes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_in_page/sign_in_page_bloc.dart';
import 'home_page_provider.dart';


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
                  context.read<SignInBloc>().add(SignOutRequested());
                  break;
                default:
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                  child: Text(
                context.read<SignInBloc>().state.authUser!.email.split('@')[0],
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
        child: RepositoryProvider.value(
          value: _batteryRepository,
          child: HomePageProvider(),
        ),
      ),
    );
  }
}
