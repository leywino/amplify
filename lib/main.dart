import 'package:amplify/presentation/home_screen/home_screen.dart';
import 'package:amplify/presentation/login_screen/login_screen.dart';
import 'package:amplify/presentation/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.comfortaaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: ScreenHome(),
    );
  }
}
