import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/screen/main_screen/on_off_restaurant.dart';


class main_page extends StatefulWidget {
  const main_page({super.key});

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow , Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
          ),
        ),
        child: ListView(
          children: [
            Container(height: 10,),

            Container(
              alignment: Alignment.center,
              child: Text(
                'Masu Merchant',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'muli',
                    fontSize: 20,
                    color: Colors.black
                ),
              ),
            ),

            Container(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4), // màu của shadow
                      spreadRadius: 5, // bán kính của shadow
                      blurRadius: 7, // độ mờ của shadow
                      offset: Offset(0, 3), // vị trí của shadow
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [Colors.yellow , Colors.white],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(height: 10,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          finalData.shop_account.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'muli',
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    Container(height: 5,),

                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined,color: Colors.black,size: 20,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                finalData.shop_account.location.mainText,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'muli',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )
                    ),

                    Container(height: 10,)
                  ],
                ),
              ),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // màu của shadow
                      spreadRadius: 5, // bán kính của shadow
                      blurRadius: 7, // độ mờ của shadow
                      offset: Offset(0, 3), // vị trí của shadow
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 15,
                      left: 15,
                      right: 10,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Doanh thu hôm nay :',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 15,
                      left: 15,
                      right: 15,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'đ',
                          style: TextStyle(
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 49.5,
                      left: 15,
                      right: 15,
                      child: Container(
                        height: 0.5,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 55,
                      left: 15,
                      right: 20,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(height: 4,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                finalData.shop_account.openStatus == 0 ? 'Đang đóng cửa' : 'Mở cửa',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: finalData.shop_account.openStatus == 0 ? Colors.grey : Colors.orange,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            Container(height: 3,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                finalData.shop_account.openStatus == 0 ? 'Bật để mở' : 'Tắt để tạm dừng nhận đơn hàng',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 10,
                      right: 15,
                      child: GestureDetector(
                        child: Icon(
                          Icons.power_settings_new,
                          color: finalData.shop_account.openStatus == 0 ? Colors.grey : Colors.deepOrange,
                          size: 25,
                        ),
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return on_off_restaurant();
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
