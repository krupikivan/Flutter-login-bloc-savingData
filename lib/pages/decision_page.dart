import 'package:flutter_bloc/bloc_helpers/bloc_provider.dart';
import 'package:flutter_bloc/bloc_widgets/bloc_state_builder.dart';
import 'package:flutter_bloc/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/blocs/authentication/authentication_state.dart';
import 'package:flutter_bloc/pages/authentication_page.dart';
import 'package:flutter_bloc/pages/home_page.dart';
import 'package:flutter/material.dart';

class DecisionPage extends StatefulWidget {
  @override
  DecisionPageState createState() {
    return new DecisionPageState();
  }
}

class DecisionPageState extends State<DecisionPage> {
  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocEventStateBuilder<AuthenticationState>(
      bloc: bloc,
      builder: (BuildContext context, AuthenticationState state) {
        if (state != oldAuthenticationState){
          oldAuthenticationState = state;

          if (state.isAuthenticated){
            _redirectToPage(context, HomePage());
          } else if (state.isAuthenticating || state.hasFailed){
  //do nothing
          } else {
            _redirectToPage(context, AuthenticationPage());
          }
        }

        return Container();
      }
    );
  }

  void _redirectToPage(BuildContext context, Widget page){
    WidgetsBinding.instance.addPostFrameCallback((_){
      MaterialPageRoute newRoute = MaterialPageRoute(
          builder: (BuildContext context) => page
        );

      Navigator.of(context).pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
  }
}