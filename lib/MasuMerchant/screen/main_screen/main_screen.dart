import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/screen/history_page/history_controller/history_controller.dart';
import 'package:masumerchant/MasuMerchant/screen/main_screen/main_screen_controller.dart';
import '../../Data/accountData/shopData/shopAccount.dart';

class main_screen extends StatefulWidget {
  const main_screen({super.key});

  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  void get_shop_account() async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child(finalData.type == 1 ? "Restaurant" : "Store").child(finalData.shop_account.id).onValue.listen((event) {
      final dynamic restaurant = event.snapshot.value;
      finalData.shop_account = ShopAccount.fromJson(restaurant);
      setState(() {

      });
    });
  }

  void get_food_order_data() async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order").orderByChild('status').equalTo('D').onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['resCost'] != null) {
          foodOrder order = foodOrder.fromJson(value);
          if (history_controller.have_restaurant_in_order(order.productList)) {
            DateTime receiverTime = DateTime(order.timeList[3].year, order.timeList[3].month, order.timeList[3].day, order.timeList[3].hour, order.timeList[3].minute, order.timeList[3].second);
            if (receiverTime.isAfter(finalData.lastOrderTime)) {
              history_controller.show_food_order_have_dialog(context, order);
              finalData.lastOrderTime = DateTime.now();
            }
          }
        }
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_shop_account();
    get_food_order_data();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: main_screen_controller.getBody(finalData.shopIndexTempotary.intData),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.yellow.withOpacity(0.4),
            labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontWeight: FontWeight.w500, fontSize: 12)
            ),
            backgroundColor: Colors.yellowAccent.withOpacity(0.05),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,

          ),
          child: NavigationBar(
            height: 70,
            selectedIndex: finalData.shopIndexTempotary.intData,
            onDestinationSelected: (selectedPage) => setState(() {finalData.shopIndexTempotary.intData = selectedPage;}),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.rocket_outlined),
                label: 'Trang chủ',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_outlined),
                label: 'Lịch sử',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book),
                label: 'Thực đơn',
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
