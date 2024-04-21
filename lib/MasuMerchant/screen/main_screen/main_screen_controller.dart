import 'package:flutter/material.dart';

import '../history_page/history_page.dart';
import '../main_page/main_page.dart';
import '../menu_page/menu_page.dart';

class main_screen_controller {
  static Widget getBody(int selectedIndex) {
    if (selectedIndex == 0) {
      return main_page();
    }
    if (selectedIndex == 1) {
      return history_page();
    }
    if (selectedIndex == 2) {
      return menu_page();
    }
    return Container();
  }
}