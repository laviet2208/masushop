import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masumerchant/MasuMerchant/screen/login_screen/login_screen.dart';
import 'package:masumerchant/MasuMerchant/screen/login_screen/wait_screen.dart';
import 'package:masumerchant/SCREEN/Tr%C6%B0%E1%BB%9Bc%20khi%20v%C3%A0o%20app/ScreenLogin.dart';


Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Masu Merchant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const wait_screen(),
    );
  }
}