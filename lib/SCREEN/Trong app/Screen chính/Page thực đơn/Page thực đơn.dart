import 'package:flutter/material.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20th%E1%BB%B1c%20%C4%91%C6%A1n/Page%20danh%20m%E1%BB%A5c.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Page%20th%E1%BB%B1c%20%C4%91%C6%A1n/Page%20m%C3%B3n%20%C4%83n.dart';

import '../../../../Data/Final.dart';

class Pagethucdon extends StatefulWidget {
  const Pagethucdon({Key? key}) : super(key: key);

  @override
  State<Pagethucdon> createState() => _PagethucdonState();
}

class _PagethucdonState extends State<Pagethucdon> {
  int selectedIndex = 0;

  Widget getWidget() {
    if (selectedIndex == 0) {
      return Pagemonan();
    }
    if (selectedIndex == 1) {
      return Pagedanhmuc(data: type.second == 0 ? 'FoodDirectory' : 'ProductDirectory',);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      width: screenWidth/2,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: selectedIndex == 0 ? Colors.orange : Colors.white
                              )
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Món ăn',
                        style: TextStyle(
                          fontSize: 14,
                          color: selectedIndex == 0 ? Colors.orange : Colors.black,
                          fontFamily: 'roboto'
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                  ),

                  GestureDetector(
                    child: Container(
                      width: screenWidth/2,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: selectedIndex == 1 ? Colors.orange : Colors.white
                              )
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Danh mục',
                        style: TextStyle(
                            fontSize: 14,
                            color: selectedIndex == 1 ? Colors.orange : Colors.black,
                            fontFamily: 'roboto'
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: 15,
            right: 15,
            bottom: 10,
            child: getWidget()
          )
        ],
      ),
    );
  }
}
