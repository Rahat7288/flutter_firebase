import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/pages/home_page/home_page.dart';
import 'package:flutter_firebase/pages/signin_signup/sign_page.dart';
import 'package:flutter_firebase/pages/signin_signup/signup_page.dart';
import 'package:flutter_firebase/pages/splash_page/splash_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        SignPage.routeName: (context) => SignPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
