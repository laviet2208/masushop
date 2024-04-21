import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/screen/history_page/history_controller/history_controller.dart';

import '../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../Data/otherData/Tool.dart';
import 'ingredient/item_un_complete_order.dart';

class complete_order_page extends StatefulWidget {
  const complete_order_page({super.key});

  @override
  State<complete_order_page> createState() => _complete_order_pageState();
}

class _complete_order_pageState extends State<complete_order_page> {
  List<foodOrder> list = [];

  void get_food_order_data() async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").orderByChild('resCost').startAt("").onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['resCost'] != null) {
          foodOrder order = foodOrder.fromJson(value);
          if (history_controller.have_restaurant_in_order(order.productList)) {
            if (order.status != 'A' || order.status != 'B' || order.status != 'C' || order.status != 'D' || order.status != 'G' || order.status != 'G1' || order.status != 'G2') {
              list.add(order);
              setState(() {
                sortByTime(list);
              });
            }
          }
        }
      });
      setState(() {

      });
    });
  }

  void sortByTime(List<foodOrder> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.timeList[3].year.compareTo(a.timeList[3].year) != 0
          ? b.timeList[3].year.compareTo(a.timeList[3].year)
          : (b.timeList[3].month.compareTo(a.timeList[3].month) != 0
          ? b.timeList[3].month.compareTo(a.timeList[3].month)
          : (b.timeList[3].day.compareTo(a.timeList[3].day) != 0
          ? b.timeList[3].day.compareTo(a.timeList[3].day)
          : (b.timeList[3].hour.compareTo(a.timeList[3].hour) != 0
          ? b.timeList[3].hour.compareTo(a.timeList[3].hour)
          : (b.timeList[3].minute.compareTo(a.timeList[3].minute) != 0
          ? b.timeList[3].minute.compareTo(a.timeList[3].minute)
          : b.timeList[3].second.compareTo(a.timeList[3].second)))));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_food_order_data();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: get_usually_decoration_type_2_gradient(),
        child: ListView.builder(
          itemCount: list.length,
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: item_un_complete_order(order: list[index]),
            );
          },
        ),
      ),
    );
  }
}
