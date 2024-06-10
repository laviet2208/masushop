import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/productDirectory.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/directory_page/ingredient/add_food_into_directory.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/directory_page/ingredient/delete_directory.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/directory_page/ingredient/view_food_in_directory/view_food_in_directory.dart';

class item_directory extends StatefulWidget {
  final productDirectory directory;
  const item_directory({super.key, required this.directory});

  @override
  State<item_directory> createState() => _item_directoryState();
}

class _item_directoryState extends State<item_directory> {
  double height = 0;
  IconData icon = Icons.keyboard_arrow_down_sharp;

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
                              fontFamily: 'muli',
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
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Thao tác',
                                  style: TextStyle(
                                      fontFamily: 'muli',
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
                            ),
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
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Text(
                                  'Xóa danh mục',
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
                          builder: (BuildContext context) {
                            return delete_directory(directory: widget.directory);
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Add sản phẩm',
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
                          builder: (BuildContext context) {
                              return add_food_into_directory(directory: widget.directory);
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
                                  'Danh sách sản phẩm',
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
                          builder: (BuildContext context) {
                            return view_food_in_directory(directory: widget.directory);
                          },
                        );
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
