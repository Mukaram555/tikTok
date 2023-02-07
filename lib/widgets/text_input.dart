import 'package:flutter/material.dart';
import 'package:ticktok/const/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final IconData myIcon;
  final String myLabel;
  final bool toHide;

  const TextInput({Key? key,required this.controller, required this.myIcon, required this.myLabel,this.toHide = false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(myIcon),
        labelText: myLabel,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
      obscureText: toHide,
    );
  }
}
