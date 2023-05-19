import 'package:dear_diary/views/home_page/widgets/scroll_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_bloc.dart';

class HomePageProvider extends BlocProvider<HomePageBloc>{

  HomePageProvider({super.key}):super(
    create:(context) => HomePageBloc()..add(BatteryPercentageFetchingStarted()),
    child: const scrollWidget(),
  );
}