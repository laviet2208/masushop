import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/Data/otherData/Tool.dart';
import 'package:masumerchant/MasuMerchant/screen/history_page/history_controller/history_controller.dart';
import 'package:masumerchant/MasuMerchant/screen/main_screen/main_screen.dart';

import '../../../Data/accountData/shopData/cartProduct.dart';
import '../../../Data/costData/Cost.dart';
import '../../../Data/voucherData/Voucher.dart';
import 'item_food_view.dart';

class view_order_detail extends StatefulWidget {
  final String id;
  const view_order_detail({super.key, required this.id});

  @override
  State<view_order_detail> createState() => _view_order_detailState();
}

class _view_order_detailState extends State<view_order_detail> {
  foodOrder order = foodOrder(
    id: generateID(25),
    locationSet: finalData.user_account.location,
    locationGet: finalData.user_account.location,
    cost: 0,
    owner: finalData.user_account,
    shipper: finalData.shipper_account,
    status: 'A',
    voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
    productList: [],
    shopList: [],
    timeList: [],
    costFee: Cost(departKM: 0, departCost: 0, milestoneKM1: 0, milestoneKM2: 0, perKMcost1: 0, perKMcost2: 0, perKMcost3: 0, discountLimit: 0, discountMoney: 0, discountPercent: 0),
    note: '',
    waitFee: 0,
    weatherFee: 0,
    pointFee: 0,
    resCost: finalData.restaurantcost,
  );

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").child(widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      order = foodOrder.fromJson(orders);
      setState(() {

      });
    });
  }

  List<cartProduct> product_of_restaurant(String shopId) {
    return order.productList.where((product) => product.product.owner == shopId).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_order_data();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: get_usually_decoration_gradient(),
            child: ListView(
              children: [
                GestureDetector(
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 5,
                          left: 10,
                          child: GestureDetector(
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          left: 60,
                          right: 60,
                          top: 0,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              order.id,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  fontFamily: 'muli',
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => main_screen(),),);
                  },
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: get_usually_decoration(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
                      child: Container(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 20),
                          itemCount: order.productList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: item_food_view(product: order.productList[index],),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                Container(height: 20,),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: get_usually_decoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(height: 20,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 17,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Thời gian nhận đơn',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'muli',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getAllTimeString(order.timeList[3]),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blueGrey,
                                        fontFamily: 'muli',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(height: 15,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 17,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Số tiền thực nhận',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'muli',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber(history_controller.get_total_food_money(product_of_restaurant(finalData.shop_account.id)) - history_controller.get_discount_cost_of_restaurant(product_of_restaurant(finalData.shop_account.id), order.resCost.discount)) + '.đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.redAccent,
                                        fontFamily: 'muli',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(height: 15,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 17,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Chiết khấu đơn',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'muli',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber(history_controller.get_discount_cost_of_restaurant(product_of_restaurant(finalData.shop_account.id), order.resCost.discount)) + '.đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'muli',
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(height: 15,),

                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 17,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text(
                                      'Trước chiết khấu',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'muli',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Text(
                                      getStringNumber(history_controller.get_total_food_money(product_of_restaurant(finalData.shop_account.id))) + '.đ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'muli',
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(height: 20,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => main_screen(),),);
        return true;
      },
    );  }
}
