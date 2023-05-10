import 'dart:developer';

import 'package:amplify/presentation/home_screen/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/text_field_widget.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateEmailField(String? value) {
    if (emailController.text.trim().isEmpty) {
      return 'Email field is empty';
    } else if (!EmailValidator.validate(emailController.text.trim())) {
      return 'Enter valid email';
    }
    return null;
  }

  String? _validatePasswordField(String? value) {
    if (passwordController.text.trim().isEmpty) {
      return 'Password field is empty';
    } else if (passwordController.text.trim().length < 8) {
      return 'Enter minimum 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 235, 235, 235),
              body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: size.height,
                  child: Form(
                    key: _formKey,
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
                          textController: emailController,
                          size: size,
                          fieldName: "Email",
                          colorValue: Colors.white,
                          validator: _validateEmailField,
                        ),
                        TextFieldWidget(
                          textController: passwordController,
                          size: size,
                          fieldName: "Password",
                          hideField: true,
                          validator: _validatePasswordField,
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        // Fourth child - Container with blue background and rounded corners
                        TextButton(
                          onPressed: () => signIn(context),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(color: Colors.black),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: size.width * 0.32,
                                    vertical: 20)),
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
          } else {
            Future.delayed(
              const Duration(milliseconds: 100),
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenHome(),
                ),
              ),
            );
          }

          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

  Future signIn(BuildContext context) async {
    final form = _formKey.currentState!.validate();
    if (form) {
      try {
        _showEmailSentSnackbar(context, "Successfully Signed In");
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        _showEmailSentSnackbar(context, e.toString());
      }
    }
  }
}

void _showEmailSentSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: 'Dismiss',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
