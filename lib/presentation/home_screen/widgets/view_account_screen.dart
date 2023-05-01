import 'package:amplify/presentation/login_screen/login_screen.dart';
import 'package:amplify/presentation/product_details/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/colors.dart';

class ViewProfileScreen extends StatelessWidget {
  ViewProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    nameController.text = user!.displayName!;
    emailController.text = user!.email!;
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            // automaticallyImplyLeading: true,
            foregroundColor: Colors.black,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset("assets/back.svg")),
            title: const Text(
              "User Details",
              style: TextStyle(
                color: kTextBlackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            children: [
              DetailsTextFieldWidget(
                size: size,
                fieldName: "Name",
                textController: nameController,
                textString: user!.displayName!,
                enableTextField: false,
              ),
              DetailsTextFieldWidget(
                size: size,
                fieldName: "Email",
                textController: emailController,
                textString: user!.email,
                enableTextField: false,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          right: 50,
          left: 50,
          child: TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenLogin(),
                ),
              );
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(
                      horizontal: size.width * 0.1, vertical: 20)),
            ),
            child: Text(
              'Log Out',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
