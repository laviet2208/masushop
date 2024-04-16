import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../Data/accountData/shopData/productDirectory.dart';
import '../../../../../Data/otherData/utils.dart';

class delete_food_from_directory extends StatefulWidget {
  final String deleteId;
  final productDirectory directory;
  const delete_food_from_directory({super.key, required this.deleteId, required this.directory});

  @override
  State<delete_food_from_directory> createState() => _delete_food_from_directoryState();
}

class _delete_food_from_directoryState extends State<delete_food_from_directory> {
  bool loading = false;
  Future<void> change_directory(productDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('FoodDirectory').child(directory.id).set(directory.toJson());
      toastMessage('Sửa danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xóa khỏi danh mục'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            widget.directory.foodList.remove(widget.deleteId);
            await change_directory(widget.directory);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text('Đồng ý', style: TextStyle(color: Colors.blueAccent),),
        ),
      ],
    );
  }
}