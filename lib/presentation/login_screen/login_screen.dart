import 'package:amplify/presentation/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/text_field_widget.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                // First child - Asset image
                // SizedBox(
                //   child: Image.asset('assets/logo_black.png'),
                //   height: 90,
                // ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                // Second child - Sign In Text
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.1,
                // ),
                // Third child - Email and Password text fields
                TextFieldWidget(
                  size: size,
                  fieldName: "Email or Phone",
                  colorValue: Colors.white,
                ),
                TextFieldWidget(
                  size: size,
                  fieldName: "Password",
                  hideField: true,
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                // Fourth child - Container with blue background and rounded corners
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenHome(),
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(
                            horizontal: size.width * 0.32, vertical: 20)),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
