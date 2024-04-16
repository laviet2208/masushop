import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/Data/FoodDirectory.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20th%E1%BB%B1c%20%C4%91%C6%A1n/Item%20danh%20m%E1%BB%A5c/Item%20m%C3%B3n%20%C4%83n%20trong%20danh%20m%E1%BB%A5c.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20th%E1%BB%B1c%20%C4%91%C6%A1n/Item%20danh%20m%E1%BB%A5c/searchPagefood.dart';

import '../../../../../Button/toast.dart';
import '../../../../../Data/Final.dart';

class Itemdanhmuc extends StatefulWidget {
  final FoodDirectory directory;
  final String data;
  const Itemdanhmuc({Key? key, required this.directory, required this.data}) : super(key: key);

  @override
  State<Itemdanhmuc> createState() => _ItemdanhmucState();
}

class _ItemdanhmucState extends State<Itemdanhmuc> {
  double height = 0;
  IconData icon = Icons.keyboard_arrow_down_sharp;

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData(List<String> FoodIdList) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data).child(widget.directory.id).child('foodList').set(FoodIdList.map((e) => e).toList());
      setState(() {
        
      });
      toastMessage('Xóa thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 16,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.directory.mainName + ' (' + widget.directory.foodList.length.toString() + ' Món)',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Thao tác',
                                style: TextStyle(
                                    fontFamily: 'arial',
                                    fontSize: 14,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.normal
                                ),
                              ),

                              Container(width: 10,),

                              Icon(
                                icon,
                                color: Colors.grey,
                                size: 16,
                              )
                            ],
                          )
                      ),
                      onTap: () {
                        if (height == 90) {
                          setState(() {
                            height = 0;
                            icon = Icons.keyboard_arrow_down_sharp;
                          });
                        } else {
                          setState(() {
                            height = 90;
                            icon = Icons.keyboard_arrow_up_outlined;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(height: 20,),

          Container(
            height: height,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Xóa danh mục',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  fontSize: 14,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),

                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                            size: 15,
                          )
                        ],
                      )
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xác nhận xóa'),
                            content: Text('Bạn có chắc chắn xóa danh mục không.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Hủy',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await deleteProduct(widget.directory.id);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Đồng ý',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),

                Container(height: 15,),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: GestureDetector(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Add món ăn',
                                style: TextStyle(
                                    fontFamily: 'arial',
                                    fontSize: 14,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ),

                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 15,
                            )
                          ],
                        )
                    ),
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(widget.data == 'Restaurant' ?'Add món ăn' : 'Add sản phẩm'),
                              content: Container(
                                height: 400,
                                width: 300,
                                child: searchPagefood(id: widget.directory.id, idshop: widget.directory.ownerID, idproduct: widget.directory.foodList, data: widget.data,),
                              ),
                            );
                          });
                    },
                  ),
                ),

                Container(height: 15,),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: GestureDetector(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Danh sách sản phẩm',
                                style: TextStyle(
                                    fontFamily: 'arial',
                                    fontSize: 14,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ),

                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 15,
                            )
                          ],
                        )
                    ),
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Danh sách sản phẩm'),
                              content: Container(
                                height: 400,
                                width: 300,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: widget.directory.foodList.length,
                                  itemBuilder: (context ,index) {
                                    return Itemmonantrongdanhmuc(id: widget.directory.foodList[index], data: type.second == 0 ? 'Food' : 'Product',
                                      deleteEvent: () async {
                                         widget.directory.foodList.removeAt(index);
                                         await pushData(widget.directory.foodList);
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 0.5,
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
