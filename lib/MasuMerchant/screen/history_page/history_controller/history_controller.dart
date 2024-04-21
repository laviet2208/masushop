import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/Product.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/cartProduct.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';

import '../../../Data/accountData/shopData/shopAccount.dart';
import '../ingredient/have_new_food_order_dialog.dart';

class history_controller {
  static Future<void> show_food_order_have_dialog(BuildContext context, foodOrder order) async {
    final player = AudioPlayer();
    await player.play(AssetSource('volume/ting.mp3'), volume: 200);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return have_new_food_order_dialog(order: order,);
      },
    );
  }

  static bool have_restaurant_in_order(List<cartProduct> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].product.owner == finalData.shop_account.id) {
        return true;
      }
    }
    return false;
  }

  static double get_total_food_money(List<cartProduct> list) {
    double money = 0;
    for(int i = 0; i < list.length; i++) {
      money = money + (list[i].number * list[i].product.cost);
    }
    return money;
  }

  static double get_discount_cost_of_restaurant(List<cartProduct> products, double discount) {
    double money = 0;
    for (cartProduct product in products) {
      double total_food_money = product.product.cost * product.number.toDouble();
      money = money + total_food_money * discount/100;
    }
    return money;
  }
}