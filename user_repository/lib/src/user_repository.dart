import 'dart:convert';
import 'package:flutter_bloc/connection.dart';
import 'package:flutter_bloc/models/user.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UserRepository {

  final String _url = 'http://' + con.getUrl() + '/login.php';
  var headers = {"accept" : "application/json"};

  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {

    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    await Future.delayed(Duration(seconds: 1));

    final response = await http.post(_url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        Map userMap = jsonDecode(response.body);
        return User.fromJson(userMap);
      }else{
        throw new Exception("No se pudo loguear!");
      }
    }

}