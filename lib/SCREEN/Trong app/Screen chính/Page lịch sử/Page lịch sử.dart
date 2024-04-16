import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20%C4%91%C6%A1n%20h%C3%A0ng/Item%20%C4%91%C6%A1n%20h%C3%A0ng%20ch%C6%B0a%20x%C3%A1c%20nh%E1%BA%ADn.dart';

import '../../../../Data/Final.dart';
import '../../../../Data/foodOrder.dart';

class PageLichsudonhang extends StatefulWidget {
  const PageLichsudonhang({Key? key}) : super(key: key);

  @override
  State<PageLichsudonhang> createState() => _PageLichsudonhangState();
}

class _PageLichsudonhangState extends State<PageLichsudonhang> {
  int index = 0;

  List<foodOrder> orderList = [];
  List<foodOrder> chosenList = [];

  void getDataorder() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/" + (type.second == 0 ? 'foodOrder' : 'productOrder')).onValue.listen((event) {
      orderList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if ((foodorder.status != 'A') && foodorder.productList[0].owner.id == currentAccount.id) {
          orderList.add(foodorder);
        }
      });
      setState(() {
        setData();
      });
    });
  }

  void setData() {
    if (index == 0) {
      chosenList.clear();
      for(foodOrder order in orderList) {
        if (order.status == 'D' || order.status == 'D1') {
          chosenList.add(order);
        }
      }
      setState(() {

      });
    }

    if (index == 1) {
      chosenList.clear();
      for(foodOrder order in orderList) {
        if (order.status == 'C') {
          chosenList.add(order);
        }
      }
      setState(() {

      });
    }

    if (index == 2) {
      chosenList.clear();
      for(foodOrder order in orderList) {
        if (order.status == 'B') {
          chosenList.add(order);
        }
      }
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataorder();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 50,
            left: 8,
            child: Container(
              width: screenWidth-16,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                      width: 2,
                      color: Colors.red
                  )
              ),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Row(
                  children: [
                    Container(width: 2,),

                    GestureDetector(
                      child: Container(
                        width: (screenWidth-14-25-5)/3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == 0 ? Colors.red : Colors.white
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Đã thanh toán',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              color: index == 0 ? Colors.white : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          index = 0;
                          setData();
                        });
                      },
                    ),

                    Container(
                      width: 7,
                    ),

                    GestureDetector(
                      child: Container(
                        width: (screenWidth-14-25-5)/3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == 1 ? Colors.red : Colors.white
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Ship đã nhận',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              color: index == 1 ? Colors.white : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          index = 1;
                          setData();
                        });
                      },
                    ),

                    Container(
                      width: 7,
                    ),

                    GestureDetector(
                      child: Container(
                        width: (screenWidth-14-25-5)/3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == 2 ? Colors.red : Colors.white
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Ship chưa nhận',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              color: index == 2 ? Colors.white : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          index = 2;
                          setData();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 110,
            bottom: 10,
            left: 15,
            right: 15,
            child: Container(
              alignment: Alignment.center,
              child: chosenList.length == 0 ? Text('Danh sách trống') : ListView.builder(
                itemCount: chosenList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context,index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Itemdonhangchuaxacnhan(order: chosenList[index]),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
