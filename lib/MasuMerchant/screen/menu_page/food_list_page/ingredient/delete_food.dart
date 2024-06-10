import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';

import '../../../../Data/accountData/shopData/Product.dart';
import '../../../../Data/otherData/utils.dart';


class delete_food extends StatefulWidget {
  final Product product;
  const delete_food({super.key, required this.product});

  @override
  State<delete_food> createState() => _delete_foodState();
}

class _delete_foodState extends State<delete_food> {
  bool loading = false;
  Future<void> delete_product() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child(finalData.type == 1 ? 'Food' : 'Product').child(widget.product.id).remove();
    toastMessage('Xóa thành công');
  }

  Future<void> deleteImage(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child(imagePath);
    try {
      await ref.delete();
      print('Xóa ảnh thành công: $imagePath');
    } catch (e) {
      print('Lỗi khi xóa ảnh: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xác nhận xóa sản phẩm'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            await deleteImage(finalData.type == 1 ? ('Food/' + widget.product.id + '.png') : ('Product/' + widget.product.id + '.png'));
            await delete_product();
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Đồng ý',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.black,),

        !loading ? TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.black,),
      ],
    );
  }
}
