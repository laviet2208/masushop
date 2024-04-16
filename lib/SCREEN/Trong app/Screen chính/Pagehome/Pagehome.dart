import 'package:flutter/material.dart';

import '../../../../Data/Final.dart';
import 'Container doanh thu.dart';

class Pagehome extends StatefulWidget {
  const Pagehome({Key? key}) : super(key: key);

  @override
  State<Pagehome> createState() => _PagehomeState();
}

class _PagehomeState extends State<Pagehome> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: screenWidth,
              height: screenHeight/3,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.orange
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(height: 60,),

                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'XEKO Merchant',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'roboto',
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                          ),

                          Container(height: 20,),

                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                currentAccount.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'roboto',
                                    fontSize: 17,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),

                          Container(height: 5,),

                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 0),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on_outlined,color: Colors.white,size: 20,),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      currentAccount.location,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'roboto',
                                          fontSize: 16,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),

                          Container(height: 70,),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 15,
                    child: Containerdoanhthu(width: screenWidth - 30, setStateEvent: () { }, data: type.second == 0 ? 'Restaurant' : 'Store',),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
