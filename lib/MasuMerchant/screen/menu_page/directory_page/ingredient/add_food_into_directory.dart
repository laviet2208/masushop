import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/productDirectory.dart';

import '../../../../Data/accountData/shopData/Product.dart';
import '../../../../Data/otherData/utils.dart';

class add_food_into_directory extends StatefulWidget {
  final productDirectory directory;
  const add_food_into_directory({super.key, required this.directory});

  @override
  State<add_food_into_directory> createState() => _add_food_into_directoryState();
}

class _add_food_into_directoryState extends State<add_food_into_directory> {
  String query = '';
  final control = TextEditingController();
  List<Product> filteredList = [];
  final List<Product> list_product = [];

  void get_product_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Food").orderByChild('owner').equalTo(widget.directory.ownerID).onValue.listen((event) {
      list_product.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Product product= Product.fromJson(value);
        if (widget.directory.foodList.contains(product.id)) {

        } else {
          list_product.add(product);
          filteredList = list_product.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
        }
      });
      setState(() {

      });
    });
  }

  Future<void> change_directory(productDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('FoodDirectory').child(directory.id).set(directory.toJson());
      toastMessage('Thêm danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_product_data();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text('Thêm món vào danh mục'),
      content: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: MediaQuery.of(context).size.height/2,
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Column(
            children: [
              TextField(
                controller: control,
                onChanged: (value) {
                  setState(() {
                    query = value;
                    filteredList = list_product.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Tìm kiếm',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(filteredList[index].name),
                        onTap: () async {
                          control.text = filteredList[index].name;
                          widget.directory.foodList.add(filteredList[index].id);
                          await change_directory(widget.directory);
                          Navigator.of(context).pop();
                          setState(() {

                          });
                        }
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
