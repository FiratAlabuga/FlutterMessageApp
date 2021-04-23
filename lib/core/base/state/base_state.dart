import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/core/constants/image/image_constants.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => Theme.of(context);
  late ImageConstants imageConstants;
  double dynamicHeight(double value) => MediaQuery.of(context).size.height * value;
  double dynamicWidth(double value) => MediaQuery.of(context).size.width * value;
}
