import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:masumerchant/MasuMerchant/screen/main_page/main_page.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/menu_page.dart';

class main_screen extends StatefulWidget {
  const main_screen({super.key});

  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  int selectedIndex = 0;

  Widget getBody() {
    if (selectedIndex == 0) {
      return main_page();
    }
    if (selectedIndex == 2) {
      return menu_page();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: getBody(),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.yellow.withOpacity(0.4),
            labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontWeight: FontWeight.w500, fontSize: 12)
            ),
            backgroundColor: Colors.yellowAccent.withOpacity(0.05),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,

          ),
          child: NavigationBar(
            height: 70,
            selectedIndex: selectedIndex,
            onDestinationSelected: (selectedPage) => setState(() {this.selectedIndex = selectedPage;}),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.rocket_outlined),
                label: 'Trang chủ',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_outlined),
                label: 'Lịch sử',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Thực đơn',
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
