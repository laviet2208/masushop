import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';

import '../../../../Data/accountData/shopData/productDirectory.dart';
import '../../../../Data/otherData/utils.dart';

class delete_directory extends StatefulWidget {
  final productDirectory directory;
  const delete_directory({super.key, required this.directory});

  @override
  State<delete_directory> createState() => _delete_directoryState();
}

class _delete_directoryState extends State<delete_directory> {
  Future<void> change_shop() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant').child(finalData.shop_account.id).set(finalData.shop_account.toJson());
      toastMessage('Xóa danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> delete_directory() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('FoodDirectory').child(widget.directory.id).remove();
    toastMessage('Xóa danh mục thành công');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xác nhận xóa danh mục'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            finalData.shop_account.listDirectory.remove(widget.directory.id);
            await delete_directory();
            await change_shop();
            Navigator.of(context).pop();
          },
          child: Text(
            'Đồng ý',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),

        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
