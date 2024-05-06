import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/directory_page/directory_page.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/food_list_page/food_list_page.dart';

class menu_page extends StatefulWidget {
  const menu_page({super.key});

  @override
  State<menu_page> createState() => _menu_pageState();
}

class _menu_pageState extends State<menu_page> with SingleTickerProviderStateMixin {
  int indexTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget getWidget() {
    if (indexTab == 0) {
      return directory_page();
    }
    if (indexTab == 1) {
      return food_list_page();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Ẩn nút back
        backgroundColor: Colors.white,
        // elevation: 0,
        title: SizedBox.shrink(),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.yellow,
              onTap: (index) {
                setState(() {
                  indexTab = index;
                });
              },
              labelStyle: TextStyle(fontFamily: 'muli', fontWeight: FontWeight.bold), // TextStyle của văn bản khi được chọn
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.yellow,
              ),
              tabs: [
                Tab(text: 'Danh mục'),
                Tab(text: 'Món ăn'),
              ],
            ),
          ],

        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [Colors.yellow , Colors.white],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   stops: [0.0, 1.0],
          // ),
          color: Colors.white,
        ),
        child: getWidget(),
      ),
    );
  }
}
