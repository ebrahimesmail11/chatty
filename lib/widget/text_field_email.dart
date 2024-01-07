import 'package:flutter/material.dart';

class TextFieldEmail extends StatelessWidget {
  const TextFieldEmail({
    super.key,
    required this.hintText,
    required this.lableText,
    this.onChanged,
  });
final String hintText;
final String lableText;
final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "* Required";
        } else
          return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        hintText: hintText,
        labelText: lableText,
        labelStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}