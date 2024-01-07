import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  const TextFieldPassword({
    super.key,
    required this.lableText,
    this.onChanged,


  });
final String lableText;

 final Function(String)? onChanged;
  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool passwordVisable =true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "* Required";
        }
          return null;
      },
      onChanged: widget.onChanged,
      obscureText: passwordVisable,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        hintText: "*******",
        labelText: widget.lableText,
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
        suffixIcon: IconButton(
          onPressed: (){
            setState(() {
              passwordVisable =! passwordVisable;
            });
          },
           icon: Icon(passwordVisable?Icons.visibility_off:Icons.visibility,color: Colors.grey,),
        ),
        alignLabelWithHint: false,
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction:TextInputAction.done ,
    );
  }
}