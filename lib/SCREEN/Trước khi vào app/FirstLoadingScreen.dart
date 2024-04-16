import 'package:flutter/material.dart';

class FirstLoadingScreen extends StatefulWidget {
  const FirstLoadingScreen({Key? key}) : super(key: key);

  @override
  State<FirstLoadingScreen> createState() => _FirstLoadingScreenState();
}

class _FirstLoadingScreenState extends State<FirstLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: screenHeight/3,
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
                top: screenHeight/3 + screenWidth/1.5,
                left: (screenWidth - MediaQuery.of(context).size.height * 0.05)/2,
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.03,
                  height: MediaQuery.of(context).size.height * 0.03,
                  child: CircularProgressIndicator(
                    value: null,
                    color: Color.fromARGB(255, 244, 164, 84),
                  ),
                ),
              ),

              Positioned(
                top: screenHeight/3 + screenWidth/1.5 + 50,
                left: 0,
                child: Container(
                  width: screenWidth,
                  alignment: Alignment.center,
                  child: Text(
                    'Đang đăng nhập',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
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
