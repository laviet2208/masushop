
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/Button/ButtonType1.dart';
import 'package:masumerchant/Data/Product.dart';
import 'package:masumerchant/Data/foodOrder.dart';

import '../../../../Button/toast.dart';
import '../../../../Data/Final.dart';

class Itemdonhangchuaxacnhan extends StatefulWidget {
  final foodOrder order;
  const Itemdonhangchuaxacnhan({Key? key, required this.order}) : super(key: key);

  @override
  State<Itemdonhangchuaxacnhan> createState() => _ItemdonhangchuaxacnhanState();
}

class _ItemdonhangchuaxacnhanState extends State<Itemdonhangchuaxacnhan> {
  String text = '';
  int status = 0;

  Future<void> changeStatus(String id, String status) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/' + (type.second == 0 ? 'foodOrder' : 'productOrder')  +'/' + id + '/status').set(status);
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0 ; i < widget.order.productList.length ; i++) {
      text = text + widget.order.productList[i].name + ' - ' + getStringNumber(widget.order.productList[i].cost) + 'đ\n';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 15,right: 10),
            child: Container(
              height: 24,
              child: Row(
                children: [
                  Icon(
                    Icons.list_alt_outlined,
                    size: 24,
                    color: Colors.orange,
                  ),

                  Container(width: 10,),

                  Padding(
                    padding: EdgeInsets.only(top: 3,bottom: 3),
                    child: Text(
                      widget.order.id,
                      style: TextStyle(
                        fontFamily: 'arial',
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.2)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(height: 8,),

                  GestureDetector(
                      child: Container(
                        height: 20,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 15,
                              child: Text(
                                type.second == 0 ? 'Đơn đồ ăn(' + widget.order.productList.length.toString() + ' món)' : 'Đơn đi chợ(' + widget.order.productList.length.toString() + ' món)',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black
                                ),
                              ),
                            ),

                            Positioned(
                                top: 0,
                                right: 15,
                                child: Icon(
                                  status == 0 ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up_outlined,
                                  color: Colors.deepOrange,
                                  size: 20,
                                )
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        if(status == 0) {
                          setState(() {
                            status = 1;
                          });
                        } else {
                          setState(() {
                            status = 0;
                          });
                        }
                      }
                  ),

                  Container(height: 8,),

                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 20),
                          child: Container(
                            height: status == 0 ? 0 : null,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.orange,
                                  fontFamily: 'arial'
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 0.5,
              decoration: BoxDecoration(
                color: Colors.deepOrange
              ),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
                alignment: Alignment.centerLeft,
                height: 20,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        'Tổng giá trị đơn',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: Text(
                        getStringNumber(widget.order.cost) + '.đ',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),

          Container(height: 5,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
                alignment: Alignment.centerLeft,
                height: 20,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        'Nhà hàng thực nhận',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: Text(
                        getStringNumber(widget.order.cost * (1 - widget.order.costFee.discount/100)) + '.đ',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ButtonType1(Height: widget.order.status == 'A' ? 37 : 0, Width: 1000, color: Colors.orange, radiusBorder: 10, title: 'Xác nhận đơn', fontText: 'arial', colorText: Colors.white,
                onTap: () async {
                  if (widget.order.status == 'A') {
                    await changeStatus(widget.order.id, 'B');
                    toastMessage('đã xác minh đơn hàng');
                  }
                }
            ),
          ),

          Container(height: 5,),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ButtonType1(Height: widget.order.status == 'A' ? 37 : 0, Width: 1000, color: Colors.redAccent, radiusBorder: 10, title: 'Từ chối đơn', fontText: 'arial', colorText: Colors.white,
                onTap: () async {
                  if (widget.order.status == 'A') {
                    await changeStatus(widget.order.id, 'G');
                    toastMessage('đã bỏ đơn hàng');
                  }
                }
            ),
          ),

          Container(height: 20,),
        ],
      ),
    );
  }
}
