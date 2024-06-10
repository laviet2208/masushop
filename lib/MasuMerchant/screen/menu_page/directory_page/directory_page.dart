import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/productDirectory.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/directory_page/ingredient/add_food_directory.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/directory_page/item_directory.dart';

class directory_page extends StatefulWidget {
  const directory_page({super.key});

  @override
  State<directory_page> createState() => _directory_pageState();
}

class _directory_pageState extends State<directory_page> {
  List<productDirectory> product_directory_list = [];

  void get_directory_data()  {
    final reference = FirebaseDatabase.instance.reference();
    reference.child(finalData.type == 1 ? 'FoodDirectory' : 'ProductDirectory').orderByChild('ownerID').equalTo(finalData.shop_account.id).onValue.listen((event) {
      product_directory_list.clear();
      final dynamic directories = event.snapshot.value;
      directories.forEach((key, value) {
        productDirectory directory = productDirectory.fromJson(value);
        product_directory_list.add(directory);
        setState(() {

        });
      });

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_directory_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
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
                  'Thêm danh mục',
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
                  return add_food_directory();
                },
              );
            },
          ),

          Container(height: 10,),

          Container(
            child: ListView.builder(
              itemCount: product_directory_list.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: item_directory(directory: product_directory_list[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
