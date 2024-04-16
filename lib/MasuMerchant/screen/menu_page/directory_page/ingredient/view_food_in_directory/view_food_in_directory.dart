import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/accountData/shopData/productDirectory.dart';
import 'package:masumerchant/MasuMerchant/screen/menu_page/directory_page/ingredient/view_food_in_directory/item_food_in_directory.dart';

class view_food_in_directory extends StatefulWidget {
  final productDirectory directory;
  const view_food_in_directory({super.key, required this.directory});

  @override
  State<view_food_in_directory> createState() => _view_food_in_directoryState();
}

class _view_food_in_directoryState extends State<view_food_in_directory> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        height: MediaQuery.of(context).size.height/3*2,
        width: MediaQuery.of(context).size.width - 30,
        child: ListView.builder(
          itemCount: widget.directory.foodList.length,
          itemBuilder: (context, index) {
            return item_food_in_directory(id: widget.directory.foodList[index], directory: widget.directory);
          },
        ),
      ),
    );
  }
}
