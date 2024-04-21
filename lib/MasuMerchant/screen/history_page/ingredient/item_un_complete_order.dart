import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/cartProduct.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/Data/otherData/Tool.dart';
import 'package:masumerchant/MasuMerchant/screen/history_page/history_controller/history_controller.dart';
import 'package:masumerchant/MasuMerchant/screen/history_page/ingredient/view_order_detail.dart';

class item_un_complete_order extends StatefulWidget {
  final foodOrder order;
  const item_un_complete_order({super.key, required this.order});

  @override
  State<item_un_complete_order> createState() => _item_un_complete_orderState();
}

class _item_un_complete_orderState extends State<item_un_complete_order> {

  String get_food_list(List<cartProduct> list) {
    String data = '';
    for (cartProduct product in list) {
      if (product.product.owner == finalData.shop_account.id) {
        data = product.number.toString() + ' x ' + product.product.name + ', ';
      }
    }
    return data.substring(0, data.length - 2);
  }

  List<cartProduct> product_of_restaurant(String shopId) {
    return widget.order.productList.where((product) => product.product.owner == shopId).toList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4), // màu của shadow
                spreadRadius: 5, // bán kính của shadow
                blurRadius: 7, // độ mờ của shadow
                offset: Offset(0, 3), // vị trí của shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 10,),

              Container(
                height: 25,
                child: Row(
                  children: [
                    Container(width: 15,),

                    Icon(
                      Icons.location_searching_sharp,
                      size: 25,
                      color: Colors.green,
                    ),

                    Container(width: 10,),

                    Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      child: Container(
                        width: width/2,
                        child: AutoSizeText(
                          'Mã đơn hàng',
                          style: TextStyle(
                              fontSize: 100,
                              color: Colors.grey,
                              fontFamily: 'muli'
                          ),
                        ),
                      ),
                    ),

                    Container(width: 10,),
                  ],
                ),
              ),

              Container(height: 8,),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.order.id,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'muli',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),

              Container(
                height: 15,
              ),

              Container(
                height: 25,
                child: Row(
                  children: [
                    Container(width: 15,),

                    Icon(
                      Icons.restaurant,
                      size: 25,
                      color: Colors.redAccent,
                    ),

                    Container(width: 10,),

                    Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      child: Container(
                        width: width/2,
                        child: AutoSizeText(
                          'Danh sách món ăn',
                          style: TextStyle(
                              fontSize: 100,
                              color: Colors.grey,
                              fontFamily: 'muli'
                          ),
                        ),
                      ),
                    ),

                    Container(width: 10,),
                  ],
                ),
              ),

              Container(height: 8,),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    get_food_list(widget.order.productList),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'muli',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),

              Container(height: 15,),

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 0.5,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
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
                            getAllTimeString(widget.order.timeList[3]),
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
                            getStringNumber(history_controller.get_total_food_money(product_of_restaurant(finalData.shop_account.id)) - history_controller.get_discount_cost_of_restaurant(product_of_restaurant(finalData.shop_account.id), widget.order.resCost.discount)) + '.đ',
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
                            getStringNumber(history_controller.get_discount_cost_of_restaurant(product_of_restaurant(finalData.shop_account.id), widget.order.resCost.discount)) + '.đ',
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

              Container(height: 15,),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => view_order_detail(id: widget.order.id),),);
      },
    );
  }
}
