import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/Button/toast.dart';
import 'package:masumerchant/Data/Final.dart';
import 'package:masumerchant/Data/Product.dart';
import 'package:masumerchant/Data/accountShop.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../../Data/Time.dart';

class Itemmonantrongdanhmuc extends StatefulWidget {
  final String id;
  final String data;
  final VoidCallback deleteEvent;
  const Itemmonantrongdanhmuc({Key? key, required this.id, required this.data, required this.deleteEvent}) : super(key: key);

  @override
  State<Itemmonantrongdanhmuc> createState() => _ItemmonantrongdanhmucState();
}

class _ItemmonantrongdanhmucState extends State<Itemmonantrongdanhmuc> {
  Product product = Product(id: '', name: '', content: '', owner: currentAccount, cost: 0, imageList: '', createTime: Time.getCurrentTime(), OpenStatus: 1);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child(widget.data).orderByChild('id').equalTo(widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;

      if (orders != null) {
        orders.forEach((key, value){
          product.ChangeData(value);
          setState(() {

          });
        });

      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              child: AutoSizeText(
                product.name + ' - ' + getStringNumber(product.cost) + 'đ' ,
              ),
            ),
          ),

          Positioned(
            top: 20,
            bottom: 20,
            right: 0,
            child: GestureDetector(
              child: Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
                size: 20,
              ),
              onTap: widget.deleteEvent,
            )
          ),

          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              height: 0.7,
              decoration: BoxDecoration(
                color: Colors.grey
              ),
            ),
          )
        ],
      )
    );
  }
}
