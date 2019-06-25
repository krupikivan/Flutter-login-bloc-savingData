import 'dart:async';

import 'package:flutter_bloc/bloc_helpers/bloc_event_state.dart';
import 'package:flutter_bloc/blocs/authentication/authentication_event.dart';
import 'package:flutter_bloc/blocs/authentication/authentication_state.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

class AuthenticationBloc
    extends BlocEventStateBase<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({
    @required this.userRepository,
  })
      : assert (userRepository != null),
        super(
        initialState: AuthenticationState.notAuthenticated(),
      );

  @override
  Stream<AuthenticationState> eventHandler(
      AuthenticationEvent event, AuthenticationState currentState) async* {

    if (event is AuthenticationEventLogin) {
      yield AuthenticationState.authenticating();

      try {
        await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );


        yield AuthenticationState.authenticated(event.username);
      } catch (error) {
        yield AuthenticationState.failure();
      }
    }

    if (event is AuthenticationEventLogout){

      yield AuthenticationState.notAuthenticated();
    }
  }
}
