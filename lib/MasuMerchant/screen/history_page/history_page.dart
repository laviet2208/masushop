import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/screen/history_page/un_complete_order_page.dart';

import 'complete_order_page.dart';

class history_page extends StatefulWidget {
  const history_page({super.key});

  @override
  State<history_page> createState() => _history_pageState();
}

class _history_pageState extends State<history_page> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: finalData.historyIndexTempotary.intData);
  }

  Widget getBody() {
    if (finalData.historyIndexTempotary.intData == 0) {
      return un_complete_order_page();
    }
    if (finalData.historyIndexTempotary.intData == 1) {
      return complete_order_page();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Ẩn nút back
        backgroundColor: Colors.white,
        elevation: 0,

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
                  finalData.historyIndexTempotary.intData = index;
                });
              },
              labelStyle: TextStyle(fontFamily: 'muli', fontWeight: FontWeight.bold), // TextStyle của văn bản khi được chọn
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.yellow,
              ),
              tabs: [
                Tab(text: 'Đơn chưa hoàn thành'),
                Tab(text: 'Đơn đã hoàn thành'),
              ],
            ),
          ],

        ),
      ),
      body: getBody(),
    );
  }
}
