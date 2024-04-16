import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/Button/toast.dart';
import 'package:masumerchant/Data/Final.dart';

import '../../../../Data/Time.dart';
import '../../../../Data/foodOrder.dart';

class Containerdoanhthu extends StatefulWidget {
  final double width;
  final VoidCallback setStateEvent;
  final String data;
  const Containerdoanhthu({Key? key, required this.width, required this.setStateEvent, required this.data}) : super(key: key);

  @override
  State<Containerdoanhthu> createState() => _ContainerdoanhthuState();
}

class _ContainerdoanhthuState extends State<Containerdoanhthu> {
  double totalMoney = 0;
  List<foodOrder> foodList = [];

  void getDatafood() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child(type.second == 0 ? "Order/foodOrder" : "Order/productOrder").onValue.listen((event) {
      foodList.clear();
      final dynamic orders = event.snapshot.value;
      totalMoney = 0;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if ((foodorder.status == 'D') && foodorder.productList[0].owner.id == currentAccount.id) {
          if (foodorder.S4time.day == Time.getCurrentTime().day && Time.getCurrentTime().month == foodorder.S4time.month && foodorder.S4time.year == Time.getCurrentTime().year) {
            totalMoney = totalMoney + (foodorder.cost * (1 - (foodorder.costFee.discount/100)));
          }
        }
      });
      setState(() {

      });
    });
  }

  Future<void> pushData(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + currentAccount.id + '/OpenStatus').set(status);
      if (status == 0) {
        toastMessage('Bạn đang ở trạng thái offline');
      }
      if (status == 1) {
        toastMessage('Bạn đang ở trạng thái online');
      }
      setState(() {

      });
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatafood();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 15,
            left: 15,
            right: 10,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Doanh thu hôm nay :',
                style: TextStyle(
                  fontFamily: 'arial',
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                getStringNumber(totalMoney) + 'đ',
                style: TextStyle(
                    fontFamily: 'arial',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Positioned(
            top: 49.5,
            left: 15,
            right: 15,
            child: Container(
              height: 0.5,
              decoration: BoxDecoration(
                color: Colors.orange
              ),
            ),
          ),

          Positioned(
            top: 55,
            left: 15,
            right: 20,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(height: 4,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                     currentAccount.OpenStatus == 0 ? 'Đang đóng cửa' : 'Mở cửa',
                     style: TextStyle(
                       fontSize: 14,
                       color: currentAccount.OpenStatus == 0 ? Colors.grey : Colors.orange,
                       fontWeight: FontWeight.bold
                     ),
                    ),
                  ),

                  Container(height: 3,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      currentAccount.OpenStatus == 0 ? 'Bật để mở' : 'Tắt để tạm dừng nhận đơn hàng',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 10,
            right: 15,
            child: GestureDetector(
              child: Icon(
                Icons.power_settings_new,
                color: currentAccount.OpenStatus == 0 ? Colors.grey : Colors.deepOrange,
                size: 25,
              ),
              onTap: () async {
                if (currentAccount.OpenStatus == 0) {
                  await pushData(1);
                  Navigator.of(context).pop();
                } else {
                  await pushData(0);
                  Navigator.of(context).pop();
                }

              },
            ),
          )
        ],
      ),
    );
  }
}
