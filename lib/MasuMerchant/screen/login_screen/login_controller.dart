import 'package:firebase_database/firebase_database.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/shopAccount.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';

class login_controller {
  static Future<bool> check_have_shop_data(String phone) async {
    final reference = FirebaseDatabase.instance.reference();
    bool check = true;
    await reference.child("Restaurant").orderByChild('phone').equalTo(phone).once().then((DatabaseEvent event) async {
      final dynamic accounts = event.snapshot.value;
      if (accounts == null) {
        check = false;
      }
    });
    return check;
  }

  static Future<void> get_and_login_shop_account(String phone) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Restaurant").orderByChild('phone').equalTo(phone).onValue.listen((event) {
      final dynamic restaurants = event.snapshot.value;
      restaurants.forEach((key, value) {
        if (finalData.shop_account.id == '') {
          finalData.shop_account = ShopAccount.fromJson(value);
        }
      });
    });
  }
}