import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumerchant/MasuMerchant/Data/otherData/Tool.dart';
import 'package:masumerchant/MasuMerchant/screen/history_page/history_controller/history_controller.dart';
import 'package:masumerchant/MasuMerchant/screen/history_page/ingredient/item_un_complete_order.dart';

class un_complete_order_page extends StatefulWidget {
  const un_complete_order_page({super.key});

  @override
  State<un_complete_order_page> createState() => _un_complete_order_pageState();
}

class _un_complete_order_pageState extends State<un_complete_order_page> {
  List<foodOrder> list = [];

  void get_food_order_data() async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").orderByChild('status').equalTo('D').onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['resCost'] != null) {
          foodOrder order = foodOrder.fromJson(value);
          if (history_controller.have_restaurant_in_order(order.productList)) {
            list.add(order);
            setState(() {

            });
          }
        }
      });
      setState(() {

      });
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
        alignment: Alignment.center,
        child: list.length != 0 ? ListView.builder(
          itemCount: list.length,
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: item_un_complete_order(order: list[index]),
            );
          },
        ) : Text('Hiện chưa có đơn nào', style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
