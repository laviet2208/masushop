import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/Button/toast.dart';
import 'package:masumerchant/Data/Product.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../Data/Final.dart';
import 'Sửa món.dart';

class Itemmonan extends StatefulWidget {
  final Product product;
  final double width;
  const Itemmonan({Key? key, required this.product, required this.width}) : super(key: key);

  @override
  State<Itemmonan> createState() => _ItemmonanState();
}

class _ItemmonanState extends State<Itemmonan> {
  Future<void> changeStatus(int status) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child((type.second == 0 ? "Food/" : "Product") + widget.product.id + "/OpenStatus").set(status);
  }

  void deleteImage(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child(imagePath);
    try {
      await ref.delete();
      print('Xóa ảnh thành công: $imagePath');
    } catch (e) {
      print('Lỗi khi xóa ảnh: $e');
    }
  }

  Future<void> deleteRequest(String id) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child((type.second == 0 ? 'Food' : 'Product') + '/' + id).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.5,
            color: Colors.orange
          ),
          borderRadius: BorderRadius.circular(5),
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
              top: 10,
              bottom: 10,
              left: 10,
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.3),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.product.imageList)
                  )
                ),
              ),
            ),

            Positioned(
              top: 10,
              left: 130,
              right: 10,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child:Text(
                        widget.product.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),

                    Container(height: 4,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        getStringNumber(widget.product.cost) + 'đ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.normal,
                            fontSize: 14
                        ),
                      ),
                    ),

                    Container(height: 6,),

                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 20),
                      child: GestureDetector(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Xóa sản phẩm',
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
                          deleteImage((type.second == 0 ? 'Food' : 'Product') + '/'+widget.product.id+'.png');
                          await deleteRequest(widget.product.id);
                        },
                      ),
                    ),

                    Container(height: 6,),

                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 20),
                      child: GestureDetector(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Chỉnh sửa',
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
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Chỉnh sửa thông tin món ăn'),
                                  content: Suamonan(shop: widget.product.owner, product: widget.product, data: type.second == 0 ? 'Food' : 'Product',),
                                );
                              }
                          );
                        },
                      ),
                    ),

                    Container(height: 6,),

                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 20),
                      child: GestureDetector(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.product.OpenStatus == 0 ? 'Đang đóng(Nhấn để mở)' : 'Đang mở(Nhấn để đóng)',
                                    style: TextStyle(
                                        fontFamily: 'arial',
                                        fontSize: 14,
                                        color: widget.product.OpenStatus == 0 ? Colors.redAccent : Colors.blueAccent,
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
                          if (widget.product.OpenStatus == 0) {
                            await changeStatus(1);
                            toastMessage('Đã mở món ăn');
                            setState(() {

                            });
                          } else {
                            await changeStatus(0);
                            toastMessage('Đã đóng món ăn');
                            setState(() {

                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
