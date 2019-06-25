import 'package:flutter_bloc/bloc_helpers/bloc_provider.dart';
import 'package:flutter_bloc/bloc_widgets/bloc_state_builder.dart';
import 'package:flutter_bloc/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/blocs/authentication/authentication_event.dart';
import 'package:flutter_bloc/blocs/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/widgets/pending_action.dart';

class AuthenticationPage extends StatelessWidget {
  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  build(context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor:Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Color(0xFF18D191))),
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: AuthenticationPageLogin(),
        ),
      ),
    );
  }
}
class AuthenticationPageLogin extends StatefulWidget {
  @override
  _AuthenticationPageLoginState createState() => _AuthenticationPageLoginState();
}

class _AuthenticationPageLoginState extends State<AuthenticationPageLogin> {


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _usernameController.text = "root";
      _passwordController.text = "root";
    });
  }


  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
          child: BlocEventStateBuilder<AuthenticationState>(
            bloc: bloc,
            builder: (BuildContext context, AuthenticationState state) {
              if (state.isAuthenticating) {
                return PendingAction();
              }

              if (state.isAuthenticated){
                return Container();
              }

              List<Widget> children = <Widget>[

              ];


              children.add(
                ListTile(
                  title: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                        child: new Text(
                          "Welcome",
                          style: new TextStyle(fontSize: 30.0),
                        ),
                      )
                    ],
                  ),
                ),
              );
              children.add(
                ListTile(
                  title: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: new TextField(
                        decoration: new InputDecoration(labelText: 'Username'),
                        controller: _usernameController,
                      ),
                    ),
                ),
              );
              children.add(
                ListTile(
                  title: SizedBox(
                      height: 15.0,
                    ),
                ),
              );
              children.add(
                  ListTile(
                      title: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: new TextField(
                        obscureText: true,
                        decoration: new InputDecoration(labelText: 'Password'),
                        controller: _passwordController,
                      ),
                    ),
                  ),
              );

              children.add(
                  ListTile(
                    title: new SizedBox(
                      height: 8.0,
                    ),
                )
              );

              // Display a text if the authentication failed
              if (state.hasFailed){
                children.add(
                  Text('Login Error!', style: TextStyle(color: Colors.red),),
                );
              }

              children.add(
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 5.0, top: 10.0),
                          child: GestureDetector(
                            onTap: () {bloc.emitEvent(AuthenticationEventLogin(username: _usernameController.text, password: _passwordController.text));},
                            child: new Container(
                                alignment: Alignment.center,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                    color: Color(0xFF18D191),
                                    borderRadius: new BorderRadius.circular(9.0)),
                                child: new Text("Login",
                                    style: new TextStyle(
                                        fontSize: 20.0, color: Colors.white))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 20.0, top: 10.0),
                          child: new Container(
                              alignment: Alignment.center,
                              height: 60.0,
                              child: new Text("Forgot Password?",
                                  style: new TextStyle(
                                      fontSize: 17.0, color: Color(0xFF18D191)))),
                        ),
                      )
                    ],
                  ),
                ),
              );

              children.add(
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom:18.0),
                          child: new Text("Create A New Account ",style: new TextStyle(
                              fontSize: 17.0, color: Color(0xFF18D191),fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
              );

              return Column(
                children: children,
              );
            },
          ),
        );
  }
}


