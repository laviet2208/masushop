import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import '../../Data/otherData/utils.dart';

class on_off_restaurant extends StatefulWidget {
  const on_off_restaurant({super.key});

  @override
  State<on_off_restaurant> createState() => _on_off_restaurantState();
}

class _on_off_restaurantState extends State<on_off_restaurant> {

  Future<void> change_shop() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(finalData.type == 1 ? 'Restaurant' : 'Store').child(finalData.shop_account.id).set(finalData.shop_account.toJson());
      toastMessage('Bật tắt thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loading = false;

    return AlertDialog(
      title: Text(finalData.shop_account.openStatus == 0 ? 'Xác nhận mở nhận đơn?' : 'Xác nhận tạm dừng nhận đơn'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            if (finalData.shop_account.openStatus == 0) {
              setState(() {
                loading = true;
              });
              finalData.shop_account.openStatus = 1;
              await change_shop();
              finalData.lastOrderTime = DateTime.now();
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              setState(() {
                loading = true;
              });
              finalData.shop_account.openStatus = 0;
              await change_shop();
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            }
          },
          child: Text('Xác nhận', style: TextStyle(color: Colors.blueAccent),),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        !loading ? TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),
      ],
    );
  }
}
