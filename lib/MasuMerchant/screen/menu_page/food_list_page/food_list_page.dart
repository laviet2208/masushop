import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/food_list_page/ingredient/add_new_food.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/food_list_page/item_food.dart';

import '../../../Data/accountData/shopData/Product.dart';

class food_list_page extends StatefulWidget {
  const food_list_page({super.key});

  @override
  State<food_list_page> createState() => _food_list_pageState();
}

class _food_list_pageState extends State<food_list_page> {
  List<Product> productList = [];

  void get_product_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Food").orderByChild('owner').equalTo(finalData.shop_account.id).onValue.listen((event) {
      productList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Product shopAccount= Product.fromJson(value);
        productList.add(shopAccount);
        sortChosenListByCreateTime(productList);
      });
      setState(() {

      });
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
    get_product_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(height: 10,),

          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: width/2),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Thêm món ăn',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'muli',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return add_new_food();
                },
              );
            },
          ),

          Container(height: 10,),

          Container(
            child: ListView.builder(
              itemCount: productList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: item_food(product: productList[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
