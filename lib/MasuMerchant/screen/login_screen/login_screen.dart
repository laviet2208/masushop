import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/Data/otherData/utils.dart';
import 'package:masumerchant/MasuMerchant/screen/login_screen/login_controller.dart';
import 'package:masumerchant/MasuMerchant/screen/main_screen/main_screen.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  bool loading = false;
  final userController = TextEditingController();
  final passController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow , Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: ListView(
            children: [
              Container(
                height: 80,
              ),

              Container(
                width: width,
                height: width/2.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage("assets/image/mainLogo.png"),
                    )
                ),
              ),

              Container(
                height: 10,
              ),

              Container(
                alignment: Alignment.center,
                child: Text(
                  'Quản lý nhà hàng Masu',
                  style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),

              Container(
                height: 20,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tên đăng nhập',
                    style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),

              Container(height: 8,),

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
                        controller: userController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên đăng nhập',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: 20,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mật khẩu',
                    style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),

              Container(height: 8,),

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
                        controller: passController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mật khẩu nhà hàng',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Container(height: 20,),

              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4), // màu của shadow
                          spreadRadius: 2, // bán kính của shadow
                          blurRadius: 7, // độ mờ của shadow
                          offset: Offset(0, 3), // vị trí của shadow
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [Colors.yellow , Colors.yellow],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                      ),
                    ),
                    child: Center(
                      child: !loading ? Text(
                        'Đăng nhập hệ thống',
                        style: TextStyle(
                          fontFamily: 'muli',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ) : CircularProgressIndicator(color: Colors.black,),
                    ),
                  ),
                ),
                onTap: () async {
                  if (userController.text.isNotEmpty && passController.text.isNotEmpty) {
                    setState(() {
                      loading = true;
                    });
                    if (await login_controller.check_have_shop_data(userController.text.toString())) {
                      await login_controller.get_and_login_shop_account(userController.text.toString());
                      if (passController.text.toString() == finalData.shop_account.password) {
                        if (finalData.shop_account.lockStatus != 0) {
                          finalData.lastOrderTime = DateTime.now();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => main_screen(),),);
                        } else {
                          toastMessage('Tài khoản đã bị khóa');
                        }
                      } else {
                        toastMessage('Kiểm tra lại mật khẩu');
                      }
                    } else {
                      toastMessage('Kiểm tra lại tài khoản');
                    }
                    setState(() {
                      loading = false;
                    });
                  } else {
                    toastMessage('Bạn cần hoàn thiện thông tin');
                  }
                },
              ),

              Container(height: 15,),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
