
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/auth_repository.dart';
import '../../shared/theme.dart';
import '../home_page/widgets/view_card.dart';
import '../sign_in_page/sign_in_bloc_provider.dart';
import '../sign_up_page/sign_up_page_provider.dart';
import '../sign_up_page/sign_up_password_page_view.dart';



class DearDiaryApp extends StatefulWidget {
  const DearDiaryApp({Key? key}) : super(key: key);

  @override
  State<DearDiaryApp> createState() => _DearDiaryAppState();
}

class _DearDiaryAppState extends State<DearDiaryApp> {
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp(routes: {
            '/': (context) =>  SignInBlocProvider(),
            '/sign_up_email': (context) => SignUpProvider(),
            '/sign_up_password': (context) => const SignUpPassword(),
            '/view_card': (context) => const ViewCard()
          },
              theme: AppTheme.lightTheme
          ),
        ),
      ),
    );
  }
}
