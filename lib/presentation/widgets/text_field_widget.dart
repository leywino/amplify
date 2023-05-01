import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.size,
      required this.fieldName,
      this.hideField = false,
      this.numPad = false,
      this.colorValue = Colors.white,
      required this.textController,
      this.validator,
      this.enabled = true});

  final Size size;
  final String fieldName;
  final bool hideField;
  final bool numPad;
  final bool enabled;
  final Color colorValue;
  final TextEditingController textController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Container(
        // height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorValue,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                fieldName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              TextFormField(
                // maxLength: 50,
                // maxLines: 5,
                controller: textController, validator: validator,
                enabled: enabled,
                obscureText: hideField,
                keyboardType: numPad ? TextInputType.phone : null,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Type here',
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
