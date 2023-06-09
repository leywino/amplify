import 'package:amplify/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ScreenLogin())),
    );
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 100,
            child: Image.asset("assets/logo_black.png"),
          ),
        ),
      ),
    );
  }
}
