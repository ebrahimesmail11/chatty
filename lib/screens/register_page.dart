import 'package:chat_setup_app/screens/login_page.dart';
import 'package:chat_setup_app/widget/icon_widget.dart';
import 'package:chat_setup_app/widget/text_field_email.dart';
import 'package:chat_setup_app/widget/text_field_password.dart';
import 'package:chat_setup_app/widget/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
   Register({super.key});
static String id ="Register";
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
String? email;

String? password;

bool isLoading=false;
   GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              textWidget(text: "Registration"),
              SizedBox(height: size.height*0.1,),
              TextFieldEmail(hintText: "Enter Your Name", lableText: "Name"),
              SizedBox(height: 32,),
              TextFieldEmail(hintText: "eamail@gmail.com",lableText: "Email",onChanged: (data){
                email=data;
              },),
              SizedBox(height: 32,),
              TextFieldPassword(lableText: "Password",onChanged: (data){
                password=data;
              },),
              SizedBox(height: 32,),
              TextFieldPassword(lableText: "Confirm Password",onChanged: (data){
                password=data;
              },),
              SizedBox(height: size.height*0.08,),
              IconWidget(
                  size: size,
                text: "Sign Up",
                onTap: ()async{
                  if(formKey.currentState!.validate()){
                    isLoading=true;
                    setState(() {

                    });
                    try{
                      await registerUser();
                      showSnakBar(context, message: "Successed");
                      Navigator.pushNamed(context, LoginPage.id);
                    }on FirebaseAuthException catch (e){
                      if(e.code=="weak-password"){
                        showSnakBar(context,message: "weak-password");
                      }else if(e.code == "email-already-in-use"){
                        showSnakBar(context, message: "email already exits");
                      }
                    }
                    isLoading=false;
                    setState(() {

                    });
                  }else{

                  }
                },
              ),
              SizedBox(height: size.height*0.08,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ? ",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                     Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:18,
                        color: Color(0xff3f3f3f),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnakBar(BuildContext context,{required String message}) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),),);
  }

  Future<void> registerUser() async {
     UserCredential credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
