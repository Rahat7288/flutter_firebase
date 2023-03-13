import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {
  static const String routeName = '/signin';
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SignIn Page')),
    );
  }
}
