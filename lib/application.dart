import 'package:flutter_bloc/bloc_helpers/bloc_provider.dart';
import 'package:flutter_bloc/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/pages/decision_page.dart';
import 'package:flutter_bloc/pages/initialization_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/pages/show_item.dart';
import 'package:user_repository/user_repository.dart';

class Application extends StatelessWidget {

  final UserRepository userRepository;

  Application({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(userRepository: userRepository),
      child: MaterialApp(
        title: 'Welcome',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/decision': (BuildContext context) => DecisionPage(),
          '/showItems': (BuildContext context) => ShowItem(),
        },
        home: InitializationPage(),

      ),
    );
  }
}
