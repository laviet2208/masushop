import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20%C4%91%C6%A1n%20h%C3%A0ng/Page%20%C4%91%C6%A1n%20h%C3%A0ng.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20th%E1%BB%B1c%20%C4%91%C6%A1n/Page%20th%E1%BB%B1c%20%C4%91%C6%A1n.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Pagehome/Container%20doanh%20thu.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Pagehome/Pagehome.dart';

import '../../../Data/Final.dart';
import 'Page lịch sử/Page lịch sử.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int selectedIndex = 0;

  Widget getBodyWidget() {
    // Dựa vào selectedIndex, trả về phần body tương ứng
    switch (selectedIndex) {
      case 0 :
        return Pagehome();
      // case 1 :
      //   return Pagedonchuanhan();
      case 1 :
        return PageLichsudonhang();
      case 2 :
        return Pagethucdon();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: getBodyWidget(),

        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.grey,
              activeColor: Color.fromARGB(255, 244, 164, 84),
              tabBackgroundColor: Color.fromARGB(100, 200, 225, 252),
              gap: 8,
              onTabChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },

              padding: EdgeInsets.all(12),
              tabs: const [
                GButton(
                  icon: Icons.rocket,
                  text: ("Trang chủ"),
                ),

                GButton(
                  icon: Icons.history,
                  text: ("Lịch sử"),
                ),

                GButton(
                  icon: Icons.restaurant_menu,
                  text: ("Thực đơn"),
                ),
              ],
            ),
          ),
        ),

      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
