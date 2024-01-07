
import 'package:chat_setup_app/helper/show_snak_bar.dart';
import 'package:chat_setup_app/screens/chat_page.dart';
import 'package:chat_setup_app/screens/register_page.dart';
import 'package:chat_setup_app/widget/icon_widget.dart';
import 'package:chat_setup_app/widget/text_field_email.dart';
import 'package:chat_setup_app/widget/text_field_password.dart';
import 'package:chat_setup_app/widget/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});

 static String id="LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
GlobalKey<FormState> formKey=GlobalKey();
bool isLoadong=false;
String? email;
String? password;
String? name;
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isLoadong,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height:  size.height*0.1,),
              textWidget(text: "Login"),
              SizedBox(height: 32,),
              Image.asset("assets/image.jpg"),
              SizedBox(height: 32,),
              TextFieldEmail(hintText: "eamail@gmail.com",lableText: "Email",onChanged: (value){
                email=value;
              }),
              SizedBox(height: 32,),
              TextFieldPassword(lableText: "Password",onChanged: (value){
                password=value;
              }),
              SizedBox(height: 32,),
              InkWell(
                onTap: (){

                },
                child: IconWidget(
                  size: size,
                  text: "Login",
                  onTap: ()async{
                    if(formKey.currentState!.validate()){
                      isLoadong=true;
                      setState(() {

                      });
                      try{
                        await loginValidiat();
                        showSnakBar(context, message: "Successed");
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      }on FirebaseAuthException catch (e){
                        if(e.code=="user-not-found"){
                          showSnakBar(context,message: "No User found for that email");
                        }else if(e.code == "wrong-password"){
                          showSnakBar(context, message: "Wrong password provided for that user .");
                        }
                      }
                      isLoadong=false;
                      setState(() {

                      });
                    }else{

                    }
                  },
                ),
              ),
              SizedBox(height: 32,),
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
                     Navigator.pushNamed(context, Register.id);
                    },
                    child: Text(
                      "Sign Up",
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

  Future<void> loginValidiat() async {
     final credint=await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!);
  }
}





