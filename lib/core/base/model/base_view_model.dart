import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/core/constants/image/image_constants.dart';

import '../../init/navigation/navigation_service.dart';

abstract class BaseViewModel {
  BuildContext? context;

  NavigationService navigationService = NavigationService.instance;
  static late ImageConstants imageConstants;

  void setContext(BuildContext context);
  void init();
}
