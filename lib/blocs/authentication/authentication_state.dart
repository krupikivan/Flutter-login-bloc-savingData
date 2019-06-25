import 'package:flutter_bloc/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';

class AuthenticationState extends BlocState {
  AuthenticationState({
    @required this.isAuthenticated,
    this.isAuthenticating: false,
    this.hasFailed: false,
    this.username: '',
  });

  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool hasFailed;

  final String username;

  factory AuthenticationState.notAuthenticated() {
    return AuthenticationState(
      isAuthenticated: false,
    );
  }

  factory AuthenticationState.authenticated(String username) {
    return AuthenticationState(
      isAuthenticated: true,
      username: username,
    );
  }

  factory AuthenticationState.authenticating() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: true,
    );
  }

  factory AuthenticationState.failure() {
    return AuthenticationState(
      isAuthenticated: false,
      hasFailed: true,
    );
  }
}
