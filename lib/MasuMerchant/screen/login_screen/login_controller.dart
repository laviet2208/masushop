import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/shopAccount.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Data/otherData/utils.dart';

class login_controller {
  static Future<bool> check_have_shop_data(String phone) async {
    final reference = FirebaseDatabase.instance.reference();
    bool check = true;
    await reference.child(finalData.type == 1 ? "Restaurant" : 'Store').orderByChild('phone').equalTo(phone).once().then((DatabaseEvent event) async {
      final dynamic accounts = event.snapshot.value;
      if (accounts == null) {
        check = false;
      }
    });
    return check;
  }

  static Future<void> saveString(String data, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  static Future<void> get_and_login_shop_account(String phone, String pass, VoidCallback callback,  VoidCallback callback1) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child(finalData.type == 1 ? "Restaurant" : 'Store').orderByChild('phone').equalTo(phone).onValue.listen((event) async {
      final dynamic restaurants = event.snapshot.value;
      await restaurants.forEach((key, value) async {
        finalData.shop_account = ShopAccount.fromJson(value);
        if (pass == value['password'].toString()) {
          if (finalData.shop_account.lockStatus != 0) {
            finalData.lastOrderTime = DateTime.now();
            await saveString(phone, 'username');
            await saveString(pass, 'password');
            callback();
          } else {
            toastMessage('Tài khoản đã bị khóa');
            callback1();
          }
        } else {
          toastMessage('Kiểm tra lại mật khẩu');
          callback1();
        }
        // finalData.shop_account.password = value['password'].toString();
        // if (finalData.shop_account.id == '') {
        //   finalData.shop_account = ShopAccount.fromJson(value);
        // }
      });
    });
  }
}