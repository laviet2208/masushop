import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../Button/toast.dart';
import '../../../../../Data/Final.dart';
import '../../../../../Data/Product.dart';


class searchPagefood extends StatefulWidget {
  final String id;
  final String idshop;
  final List<String> idproduct;
  final String data;
  const searchPagefood({Key? key, required this.id, required this.idshop, required this.idproduct, required this.data,}) : super(key: key);

  @override
  State<searchPagefood> createState() => _searchPageState();
}

class _searchPageState extends State<searchPagefood> {
  List<Product> list = [];
  String query = '';
  final control = TextEditingController();

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child(type.second == 0 ? "Food" : "Product").onValue.listen((event) {
      list.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Product food= Product.fromJson(value);
        if (widget.idshop == food.owner.id) {
          list.add(food);
        }
      });
      setState(() {
        sortChosenListByCreateTime(list);
      });
    });
  }

  void sortChosenListByCreateTime(List<Product> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.createTime.year.compareTo(a.createTime.year) != 0
          ? b.createTime.year.compareTo(a.createTime.year)
          : (b.createTime.month.compareTo(a.createTime.month) != 0
          ? b.createTime.month.compareTo(a.createTime.month)
          : (b.createTime.day.compareTo(a.createTime.day) != 0
          ? b.createTime.day.compareTo(a.createTime.day)
          : (b.createTime.hour.compareTo(a.createTime.hour) != 0
          ? b.createTime.hour.compareTo(a.createTime.hour)
          : (b.createTime.minute.compareTo(a.createTime.minute) != 0
          ? b.createTime.minute.compareTo(a.createTime.minute)
          : b.createTime.second.compareTo(a.createTime.second)))));
    });
  }

  Future<void> pushData(String id, String id1, List<String> newlist) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      newlist.add(id1);
      await databaseRef.child(widget.data + '/' + id + "/foodList").set(newlist);
      toastMessage('Thêm vào danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> filteredList = list.where((Product) => Product.name.toLowerCase().contains(query.toLowerCase())).toList();
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          TextField(
            controller: control,
            onChanged: (value) {
              setState(() {
                query = value;
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xác nhận thêm'),
                            content: Text('Bạn có chắc chắn thêm không.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Hủy',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await pushData(widget.id, filteredList[index].id, widget.idproduct);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Đồng ý',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      setState(() {

                      });
                    }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}