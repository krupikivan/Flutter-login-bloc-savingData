import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/application.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
void main() {
  debugPaintSizeEnabled = false;
  runApp(Application(userRepository: UserRepository()));
}
