import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/Data/otherData/Tool.dart';

import '../../../../Data/accountData/shopData/Product.dart';
import '../../../../Data/otherData/utils.dart';

class add_new_food extends StatefulWidget {
  const add_new_food({super.key});

  @override
  State<add_new_food> createState() => _add_new_foodState();
}

class _add_new_foodState extends State<add_new_food> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  Uint8List? registrationImage;
  bool loading = false;
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
      await databaseRef.child(finalData.type == 1 ? 'Food' : 'Product').child(food.id).set(food.toJson());
      toastMessage('sửa thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes, String imageName) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child(finalData.type == 1 ? 'Food/$imageName.png' : 'Product/$imageName.png');
      SettableMetadata metadata = SettableMetadata(contentType: 'image/png');
      UploadTask uploadTask = storageReference.putData(imageBytes, metadata);
      // Lắng nghe sự kiện khi upload hoàn thành
      await uploadTask.whenComplete(() => print('Upload completed'));
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: MediaQuery.of(context).size.height/4*3,
        child: ListView(
          children: <Widget>[
            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                finalData.type == 1 ? 'Tên món ăn *' : 'Tên sản phẩm *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                        controller: nameController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: finalData.type == 1 ? 'Nhập tên món ăn' : 'Nhập tên sản phẩm',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
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
                finalData.type == 1 ? 'Mô tả món ăn *' : 'Mô tả sản phẩm *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                        controller: subController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: finalData.type == 1 ? 'Mô tả món ăn' : 'Mô tả sản phẩm',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
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
                finalData.type == 1 ? 'Giá tiền món ăn *' : 'Giá tiền sản phẩm *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                        controller: costController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))], // Giới hạn chỉ nhập số
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập giá sản phẩm',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
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
                'Hình ảnh của sản phẩm',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'muli',
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
              padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width - 130)/2, right: (MediaQuery.of(context).size.width - 130)/2),
              child: GestureDetector(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child:registrationImage == null
                        ? Icon(Icons.image_outlined, size: 30.0, color: Colors.grey,)
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

            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: !loading ? Center(
                    child: Text(
                      'Lưu sản phẩm',
                      style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ) : CircularProgressIndicator(color: Colors.black,),
                ),
              ),
              onTap: () async {
                if(nameController.text.isNotEmpty && subController.text.isNotEmpty && costController.text.isNotEmpty && registrationImage != null) {
                  setState(() {
                    loading = true;
                  });
                  Product product = Product(
                    id: generateID(20),
                    cost: double.parse(costController.text.toString()),
                    name: nameController.text.toString(),
                    describle: subController.text.toString(),
                    owner: finalData.shop_account.id,
                    status: 0,
                    createTime: getCurrentTime(),
                  );
                  await uploadImageToFirebaseStorage(registrationImage!, product.id);
                  await pushData(product);
                  setState(() {
                    loading = false;
                  });
                  Navigator.of(context).pop();
                } else {
                  toastMessage('điền đủ thông tin trước');
                }
              },
            ),

            Container(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
