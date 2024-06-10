import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/OrderData/foodOrder/foodOrder.dart';

class have_new_food_order_dialog extends StatefulWidget {
  final foodOrder order;
  const have_new_food_order_dialog({super.key, required this.order});

  @override
  State<have_new_food_order_dialog> createState() => _have_new_food_order_dialogState();
}

class _have_new_food_order_dialogState extends State<have_new_food_order_dialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    double height = MediaQuery.of(context).size.height/2;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text('Masu có đơn'),
      content: Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 20,),

            Container(
              height: 20,
              alignment: Alignment.center,
              child: AutoSizeText(
                'Chúc mừng, bạn có đơn mới',
                style: TextStyle(
                    fontSize: 100,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Container(height: 20,),

            Container(
                height: 50,
                alignment: Alignment.center,
                child: Center(
                  child: Icon(
                    Icons.restaurant,
                    color: Colors.green,
                    size: 50,
                  ),
                )
            ),

            Container(height: 20,),

            Container(
              alignment: Alignment.center,
              child: Text(
                'Đơn hàng\n' + widget.order.id,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Container(height: 20,),

            GestureDetector(
              child: Container(
                height: 45,
                child: Center(
                  child: Container(
                    width: width/2,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: AutoSizeText(
                        'Xem đơn ngay',
                        style: TextStyle(
                            fontSize: 100,
                            fontFamily: 'roboto',
                            color: Colors.black,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
              },
            ),

            Container(height: 20,),
          ],
        ),
      ),
    );
  }
}
