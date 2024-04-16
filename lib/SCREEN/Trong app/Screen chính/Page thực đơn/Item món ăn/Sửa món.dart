
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Button/ButtonType1.dart';
import '../../../../../Button/toast.dart';
import '../../../../../Data/Product.dart';
import '../../../../../Data/Time.dart';
import '../../../../../Data/accountShop.dart';

class Suamonan extends StatefulWidget {
  final accountShop shop;
  final Product product;
  final String data;
  const Suamonan({Key? key, required this.shop, required this.product, required this.data}) : super(key: key);

  @override
  State<Suamonan> createState() => _SuamonanState();
}

class _SuamonanState extends State<Suamonan> {
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t3 = TextEditingController();
  final TextEditingController t2 = TextEditingController();
  Uint8List? registrationImage;
  bool loading = false;
  String Downloadurl = 'https://firebasestorage.googleapis.com/v0/b/xekoship-a0057.appspot.com/o/favicon.png?alt=media&token=4c3d22bf-971b-45af-9ebe-9561bd74d469';
  final picker = ImagePicker();

  Future<Uint8List?> galleryImagePicker() async {
    final ImagePicker _picker = ImagePicker();

    // Chọn hình ảnh từ thư viện ảnh
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      // Người dùng không chọn hình ảnh
      return null;
    }

    // Đọc dữ liệu từ hình ảnh đã chọn
    List<int> imageBytes = await pickedFile.readAsBytes();

    // Chuyển đổi List<int> thành Uint8List
    Uint8List? bytesFromPicker = Uint8List.fromList(imageBytes);

    return bytesFromPicker;
  }

  Future<void> pushData(Product food) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data).child(food.id).set(food.toJson());
      toastMessage('sửa thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes, String imageName) async {
    try {
      // Tạo tham chiếu đến Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child(widget.data + '/$imageName.png');

      // Đặt loại (MIME type) là 'image/png'
      SettableMetadata metadata = SettableMetadata(contentType: 'image/png');

      // Upload dữ liệu của ảnh lên Firebase Storage với metadata
      UploadTask uploadTask = storageReference.putData(imageBytes, metadata);

      // Lắng nghe sự kiện khi upload hoàn thành
      await uploadTask.whenComplete(() => print('Upload completed'));

      // Lấy URL của ảnh từ Firebase Storage
      String imageUrl = await storageReference.getDownloadURL();
      Downloadurl = imageUrl;
      // In ra URL của ảnh
      print('Image URL: $imageUrl');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    t1.text = widget.product.content;
    t2.text = widget.product.name;
    t3.text = widget.product.cost.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 600,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            width: 1,
            color: Colors.black,
          )
      ),

      child: ListView(
        children: <Widget>[
          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Tên món ăn *',
              style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    )
                ),

                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Form(
                    child: TextFormField(
                      controller: t1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'arial',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập tên món ăn',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                      ),
                    ),
                  ),
                ),
              )
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Mô tả món ăn *',
              style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    )
                ),

                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Form(
                    child: TextFormField(
                      controller: t2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'arial',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập tên món ăn',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                      ),
                    ),
                  ),
                ),
              )
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Giá tiền món ăn *',
              style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent
              ),
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    )
                ),

                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Form(
                    child: TextFormField(
                      controller: t3,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'arial',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập giá món ăn',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                      ),
                    ),
                  ),
                ),
              )
          ),

          Container(
            height: 20,
          ),

          Container(
            alignment: Alignment.center,
            child: Text(
                'Hình ảnh của món ăn',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: GestureDetector(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.redAccent,
                        width: 2,
                    ),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child:registrationImage == null
                      ? Icon(Icons.add, size: 30.0, color: Colors.redAccent,)
                      : Image.memory(registrationImage!, fit: BoxFit.fitHeight,),
                ),
              ),
              onTap: () async {
                final Uint8List? image = await galleryImagePicker();

                if (image != null) {
                  registrationImage = image;
                  setState(() {});
                }
              },
            ),
          ),

          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: ButtonType1(Height: 40, Width: 100, color: Colors.redAccent, radiusBorder: 20, title: 'Cập nhật món ăn', fontText: 'roboto', colorText: Colors.white,
                onTap: () async {
                  if(t1.text.isNotEmpty && t2.text.isNotEmpty && t3.text.isNotEmpty) {
                    setState(() {
                      loading = true;
                    });
                    if (registrationImage != null) {
                      await uploadImageToFirebaseStorage(registrationImage!, widget.product.id);
                    }
                    if (registrationImage != null) {
                      Product pro = Product(id: widget.product.id, name: t2.text.toString(), content: t1.text.toString(), owner: widget.shop, cost: double.parse(t3.text.toString()), imageList: Downloadurl,createTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year), OpenStatus: 0,);
                      await pushData(pro);
                    } else {
                      Product pro = Product(id: widget.product.id, name: t2.text.toString(), content: t1.text.toString(), owner: widget.shop, cost: double.parse(t3.text.toString()), imageList: widget.product.imageList,createTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year), OpenStatus: 0,);
                      await pushData(pro);
                    }

                    Navigator.of(context).pop();
                  } else {
                    toastMessage('điền đủ thông tin trước');
                  }
                }, loading: loading,
                )
          ),

          Container(
            height: 10,
          ),
        ],
      ),
    );
  }
}
