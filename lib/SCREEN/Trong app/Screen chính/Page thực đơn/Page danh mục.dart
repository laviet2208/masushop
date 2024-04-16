import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/Data/Final.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20th%E1%BB%B1c%20%C4%91%C6%A1n/Item%20danh%20m%E1%BB%A5c/Item%20danh%20m%E1%BB%A5c.dart';

import '../../../../Data/FoodDirectory.dart';
import 'Item danh mục/Thêm danh mục đồ ăn.dart';

class Pagedanhmuc extends StatefulWidget {
  final String data;
  const Pagedanhmuc({Key? key, required this.data}) : super(key: key);

  @override
  State<Pagedanhmuc> createState() => _PagedanhmucState();
}

class _PagedanhmucState extends State<Pagedanhmuc> {
  List<FoodDirectory> foodDirecList = [];
  List<FoodDirectory> chosenList = [];

  void getData()  {
    final reference = FirebaseDatabase.instance.reference();
    reference.child(widget.data).onValue.listen((event) {
      foodDirecList.clear();
      chosenList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        FoodDirectory acc = FoodDirectory.fromJson(value);
        if (acc.ownerID == currentAccount.id) {
          foodDirecList.add(acc);
          chosenList.add(acc);
        }

        setState(() {

        });
      });

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
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 0,
            right: 230,
            child: GestureDetector(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15)
                ),
                alignment: Alignment.center,
                child: Text(
                  'Thêm danh mục',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              onTap: () {
                Themdanhmucdoan.showdialog(300, 200, context, TextEditingController(), currentAccount, type.second == 0 ? 'Restaurant' : 'Store');
              },
            ),
          ),

          Positioned(
            top: 60,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: chosenList.length == 0 ? Text('Danh sách trống') : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: chosenList.length,
                itemBuilder: (context , index) {
                  return Itemdanhmuc(directory: chosenList[index], data: type.second == 0 ? 'FoodDirectory' : 'ProductDirectory',);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
