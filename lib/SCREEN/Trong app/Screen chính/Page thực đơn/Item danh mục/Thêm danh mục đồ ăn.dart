import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../Button/toast.dart';
import '../../../../../Data/FoodDirectory.dart';
import '../../../../../Data/Time.dart';
import '../../../../../Data/accountShop.dart';

class Themdanhmucdoan {
  static Future<void> pushData(FoodDirectory foodDirectory, String data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(data == 'Restaurant' ? 'FoodDirectory' : 'ProductDirectory').child(foodDirectory.id).set(foodDirectory.toJson());
      toastMessage('Thêm danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> pushData1(accountShop foodDirectory, String id, String data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      foodDirectory.ListDirectory.add(id);
      await databaseRef.child(data).child(foodDirectory.id).child('ListDirectory').set(foodDirectory.ListDirectory);
      toastMessage('Thêm danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static void showdialog(double width, double height, BuildContext context, TextEditingController textEditingController, accountShop shop, String data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Thêm danh mục'),
              content: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    )
                ),
                child: ListView(
                  children: [
                    Container(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Tên danh mục đồ ăn *',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent
                        ),
                      ),
                    ),

                    Container(
                      height: 10,
                    ),

                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              )
                          ),

                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Form(
                              child: TextFormField(
                                controller: textEditingController,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Tên danh mục',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: 'arial',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Hủy'),
                  onPressed: () {
                    textEditingController.clear();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  onPressed: () async {
                    if (textEditingController.text.isNotEmpty) {
                      FoodDirectory direct = FoodDirectory(
                          id: Time.generateRandomString(20),
                          mainName: textEditingController.text.toString(),
                          foodList: [],
                          ownerID: shop.id
                      );
                      await pushData(direct, data);
                      await pushData1(shop, direct.id, data);
                      Navigator.of(context).pop();
                    } else {
                      toastMessage('Vui lòng điền tên danh mục');
                    }
                  },
                  child: Text('Đồng ý'),
                )
              ]
          );
        }
    );
  }
}