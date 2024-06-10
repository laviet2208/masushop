import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/Product.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/food_list_page/ingredient/edit_food.dart';

import '../../../Data/otherData/Tool.dart';
import 'ingredient/delete_food.dart';
import 'ingredient/on_off_food.dart';

class item_food extends StatefulWidget {
  final Product product;
  const item_food({super.key, required this.product});

  @override
  State<item_food> createState() => _item_foodState();
}

class _item_foodState extends State<item_food> {

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), // màu của shadow
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
              child: FutureBuilder(
                future: finalData.type == 1 ? _getImageURL('Food/' + widget.product.id + '.png') : _getImageURL('Product/' + widget.product.id + '.png'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: Colors.yellow, strokeWidth: 3,);
                  }

                  if (snapshot.hasError) {
                    return Container(
                      height: 110,
                      width: 110,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_outlined,
                        color: Colors.grey,
                        size: 30,
                      ),
                    );
                  }

                  return Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.3),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(snapshot.data!),
                        )
                    ),
                  );
                },
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
                            fontFamily: 'muli',
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
                            fontFamily: 'muli',
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
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Xóa sản phẩm',
                                    style: TextStyle(
                                        fontFamily: 'muli',
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
                            builder: (context) {
                              return delete_food(product: widget.product);
                            },
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
                                    'Chỉnh sửa',
                                    style: TextStyle(
                                        fontFamily: 'muli',
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
                            builder: (context) {
                              return edit_food(product: widget.product);
                            },
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
                                    widget.product.status == 0 ? 'Đang đóng(Nhấn để mở)' : 'Đang mở(Nhấn để đóng)',
                                    style: TextStyle(
                                        fontFamily: 'muli',
                                        fontSize: 14,
                                        color: widget.product.status == 0 ? Colors.redAccent : Colors.blueAccent,
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
                            builder: (context) {
                              return on_off_food(product: widget.product);
                            },
                          );
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
