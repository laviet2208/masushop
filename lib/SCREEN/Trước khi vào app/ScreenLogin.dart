import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/Button/ButtonType1.dart';
import 'package:masumerchant/Button/toast.dart';
import 'package:masumerchant/Data/Final.dart';
import 'package:masumerchant/Data/accountShop.dart';
import 'package:masumerchant/SCREEN/Trong%20app/Screen%20ch%C3%ADnh/Screen%20ch%C3%ADnh.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  int index = 0;
  bool loading = false;
  final UserController = TextEditingController();
  final PassController = TextEditingController();

  Future<void> getData(String data) async {
    setState(() {
      loading = true;
    });

    final reference = FirebaseDatabase.instance.reference();
    reference.child(data).orderByChild('phoneNum').equalTo(UserController.text.toString()).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;

      if (orders != null) {
        print(orders.toString());
        orders.forEach((key, value){
          currentAccount.changeData(value);
          if (PassController.text.toString() == currentAccount.password) {
            setState(() {

            });
            print(currentAccount.toJson().toString());
            type.second = index;
            Navigator.push(context, MaterialPageRoute(builder:(context) => ScreenMain()));
          } else {
            setState(() {
              loading = false;
            });
            toastMessage('Kiểm tra lại mật khẩu');
          }
        });

      } else {
        setState(() {
          loading = false;
          toastMessage('Vui lòng kiếm tra tên đăng nhập');
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: screenHeight/5,
                left: (screenWidth-screenWidth/2.5)/2,
                child: Container(
                  width: screenWidth/2.5,
                  height: screenWidth/2.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/image/mainLogo.png"),
                      )
                  ),
                ),
              ),

              Positioned(
                top: screenHeight/5 + screenWidth/2.5 + 50,
                left: 20,
                right: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(

                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: GestureDetector(
                              child: Container(
                                height: 50,
                                width: (screenWidth-50)/2,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.5,
                                            color: index == 0 ? Color.fromARGB(255, 244, 164, 84) : Colors.white
                                        )
                                    )
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Nhà hàng',
                                  style: TextStyle(
                                      fontFamily: 'roboto',
                                      color: Colors.black,
                                      fontSize: 14
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  index = 0;
                                });
                              },
                            ),
                          ),

                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              child: Container(
                                height: 50,
                                width: (screenWidth-50)/2,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.5,
                                            color: index == 1 ? Color.fromARGB(255, 244, 164, 84) : Colors.white
                                        )
                                    )
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Cửa hàng',
                                  style: TextStyle(
                                      fontFamily: 'roboto',
                                      color: Colors.black,
                                      fontSize: 14
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  index = 1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 30,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tên đăng nhập',
                        style: TextStyle(
                          fontFamily: 'roboto',
                          color: Color.fromARGB(255, 244, 164, 84),
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Container(height: 5,),

                    Container(
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
                            color: Color.fromARGB(255, 244, 164, 84),
                          )
                      ),

                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Form(
                          child: TextFormField(
                            controller: UserController,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'arial',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tên đăng nhập',
                              hintStyle: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontFamily: 'arial',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(height: 15,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mật khẩu',
                        style: TextStyle(
                            fontFamily: 'roboto',
                            color: Color.fromARGB(255, 244, 164, 84),
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Container(height: 5,),

                    Container(
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
                            color: Color.fromARGB(255, 244, 164, 84),
                          )
                      ),

                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Form(
                          child: TextFormField(
                            controller: PassController,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'arial',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Mật khẩu',
                              hintStyle: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontFamily: 'arial',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(height: 15,),

                    ButtonType1(Height: 50, Width: 1000, color : Color.fromARGB(255, 244, 164, 84), radiusBorder: 10, title: index == 0 ? 'Đăng nhập nhà hàng' : 'Đăng nhập cửa hàng', fontText: 'roboto', colorText: Colors.white,
                        onTap: () async {
                          if(UserController.text.isNotEmpty && PassController.text.isNotEmpty) {
                            await getData(index == 0 ? 'Restaurant' : 'Store');
                          } else {
                            toastMessage('Bạn cần điền đủ tên đăng nhập và mật khẩu');
                          }
                        }, loading: loading,
                    ),
                  ],
                ),
              )
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
