import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../Data/Final.dart';
import '../../../../Data/foodOrder.dart';
import 'Item đơn hàng chưa xác nhận.dart';

class Pagedonchuanhan extends StatefulWidget {
  const Pagedonchuanhan({Key? key}) : super(key: key);

  @override
  State<Pagedonchuanhan> createState() => _PagedonchuanhanState();
}

class _PagedonchuanhanState extends State<Pagedonchuanhan> {
  List<foodOrder> orderList = [];

  void getDataorder() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/" + (type.second == 0 ? 'foodOrder' : 'productOrder')).onValue.listen((event) {
      orderList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if ((foodorder.status == 'A') && foodorder.productList[0].owner.id == currentAccount.id) {
          orderList.add(foodorder);
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
    getDataorder();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      alignment: Alignment.center,
      child: orderList.length == 0 ? Text('Danh sách trống') : Padding(
        padding: EdgeInsets.only(left: 15,right: 15, top: 60, bottom: 10),
        child: ListView.builder(
            itemCount: orderList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context , index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Itemdonhangchuaxacnhan(order: orderList[index]),
              );
            }
        ),
      )
    );
  }
}
