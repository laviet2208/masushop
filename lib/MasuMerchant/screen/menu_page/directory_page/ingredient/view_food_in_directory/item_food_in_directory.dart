import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/Product.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/productDirectory.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/Data/otherData/Time.dart';

import '../../../../../Data/otherData/Tool.dart';
import 'delete_food_from_directory.dart';

class item_food_in_directory extends StatefulWidget {
  final String id;
  final productDirectory directory;
  const item_food_in_directory({super.key, required this.id, required this.directory});

  @override
  State<item_food_in_directory> createState() => _item_food_in_directoryState();
}

class _item_food_in_directoryState extends State<item_food_in_directory> {
  Product product = Product(id: '', cost: 0, name: '', describle: '', owner: '', status: 0, createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),);

  void get_product_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child(finalData.type == 1 ? "Food" : "Product").child(widget.id).onValue.listen((event) {
      final dynamic pro = event.snapshot.value;
      if (pro != null) {
        product = Product.fromJson(pro);
        setState(() {

        });
      } else {
        widget.directory.foodList.remove(widget.id);
        change_directory(widget.directory);
      }
    });
  }

  Future<void> change_directory(productDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(finalData.type == 1 ? 'FoodDirectory' : 'ProductDirectory').child(directory.id).set(directory.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_product_data();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 2,
              bottom: 2,
              left: 2,
              child: FutureBuilder(
                future: finalData.type == 1 ? _getImageURL('Food/' + product.id + '.png') : _getImageURL('Product/' + product.id + '.png'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: Colors.yellow, strokeWidth: 3,);
                  }

                  if (snapshot.hasError) {
                    return Container(
                      width: 56,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image,
                        color: Colors.grey,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Container(
                      width: 56,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image,
                        color: Colors.grey,
                      ),
                    );
                  }

                  return Container(
                    width: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(snapshot.data!),
                      )
                    ),
                  );
                },
              ),
            ),

            Positioned(
              top: 20,
              bottom: 20,
              left: 65,
              right: 40,
              child: Container(
                child: AutoSizeText(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'muli',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            Positioned(
                top: 20,
                bottom: 20,
                right: 10,
                child: GestureDetector(
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return delete_food_from_directory(deleteId: widget.id, directory: widget.directory);
                      },
                    );
                  },
                )
            ),

            Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: Container(
                height: 0.7,
                decoration: BoxDecoration(
                    color: Colors.grey
                ),
              ),
            )
          ],
        )
    );
  }
}
