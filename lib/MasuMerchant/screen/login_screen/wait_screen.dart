import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/Data/finalData/finalData.dart';
import 'package:masumerchant/MasuMerchant/screen/login_screen/login_controller.dart';
import 'package:masumerchant/MasuMerchant/screen/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Data/otherData/utils.dart';
import '../main_screen/main_screen.dart';

class wait_screen extends StatefulWidget {
  const wait_screen({super.key});

  @override
  State<wait_screen> createState() => _wait_screenState();
}

class _wait_screenState extends State<wait_screen> {
  String? name = '';
  String? pass = '';

  Future<void> getSavedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('username');
    pass = prefs.getString('password');
    if (name != '' && pass != '' && name != null && pass != null) {
      if (await login_controller.check_have_shop_data(name!)) {
        await login_controller.get_and_login_shop_account(name!);
        if (pass == finalData.shop_account.password) {
          if (finalData.shop_account.lockStatus != 0) {
            finalData.lastOrderTime = DateTime.now();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => main_screen(),),);
          } else {
            toastMessage('Tài khoản đã bị khóa');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => login_screen(),),);
          }
        } else {
          // toastMessage('Kiểm tra lại mật khẩu');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => login_screen(),),);
        }
      } else {
        toastMessage('Kiểm tra lại tài khoản');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => login_screen(),),);
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => login_screen(),),);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedata();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/background.png'),
                      fit: BoxFit.fitHeight,
                    )
                  ),
                ),
              ),
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
