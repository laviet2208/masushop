import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20th%E1%BB%B1c%20%C4%91%C6%A1n/Item%20danh%20m%E1%BB%A5c/Item%20m%C3%B3n%20%C4%83n%20trong%20danh%20m%E1%BB%A5c.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20th%E1%BB%B1c%20%C4%91%C6%A1n/Item%20m%C3%B3n%20%C4%83n/Item%20m%C3%B3n%20%C4%83n.dart';

import '../../../../Data/Final.dart';
import '../../../../Data/Product.dart';
import 'Item món ăn/Thêm món ăn.dart';

class Pagemonan extends StatefulWidget {
  const Pagemonan({Key? key}) : super(key: key);

  @override
  State<Pagemonan> createState() => _PagemonanState();
}

class _PagemonanState extends State<Pagemonan> {
  List<Product> foodList = [];
  List<Product> chosenList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child(type.second == 0 ? 'Food' : 'Product').onValue.listen((event) {
      foodList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Product food= Product.fromJson(value);
        if(food.owner.id == currentAccount.id) {
          foodList.add(food);
          chosenList.add(food);
        }
      });
      setState(() {
        sortChosenListByCreateTime(chosenList);
      });
    });
  }

  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = foodList
          .where((account) =>
      account.name.toLowerCase().contains(value.toLowerCase()) ||
          account.content.toLowerCase().contains(value.toLowerCase()) ||
          account.cost.toString().toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void sortChosenListByCreateTime(List<Product> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.createTime.year.compareTo(a.createTime.year) != 0
          ? b.createTime.year.compareTo(a.createTime.year)
          : (b.createTime.month.compareTo(a.createTime.month) != 0
          ? b.createTime.month.compareTo(a.createTime.month)
          : (b.createTime.day.compareTo(a.createTime.day) != 0
          ? b.createTime.day.compareTo(a.createTime.day)
          : (b.createTime.hour.compareTo(a.createTime.hour) != 0
          ? b.createTime.hour.compareTo(a.createTime.hour)
          : (b.createTime.minute.compareTo(a.createTime.minute) != 0
          ? b.createTime.minute.compareTo(a.createTime.minute)
          : b.createTime.second.compareTo(a.createTime.second)))));
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
    double screenWidth = MediaQuery.of(context).size.width;

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
                  'Thêm món ăn',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              onTap: () {
                ThemMonAn.showDialogthemmonan(400, 500, context,currentAccount,TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(),type.second == 0 ? 'Food' : 'Product');
              },
            ),
          ),

          Positioned(
            top: 60,
            bottom: 0,
            left: 0,
            right: 0,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: chosenList.length,
              itemBuilder: (context , index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Itemmonan(product: chosenList[index], width: screenWidth - 30,),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
