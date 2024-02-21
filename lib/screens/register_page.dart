import 'package:chat_setup_app/controller/cubit/auth_cubit.dart';
import 'package:chat_setup_app/controller/cubit/auth_cubit_state.dart';
import 'package:chat_setup_app/screens/chat_page.dart';
import 'package:chat_setup_app/widget/icon_widget.dart';
import 'package:chat_setup_app/widget/text_field_email.dart';
import 'package:chat_setup_app/widget/text_field_password.dart';
import 'package:chat_setup_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controller/chat_cubit/chat_cubit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static String id = "Register";


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpLoadingState) {
         const  CircularProgressIndicator();
        } else if (state is SignUpSuccessState) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: authCubit.email);
        } else if (state is SignUpFailureState) {
          showSnakBar(context, message: "weak-password");
        } else if (state is SignUpFailureState) {
          // isLoading=false;
          showSnakBar(context, message: "email already exits");
        } else {
          showSnakBar(context, message: 'Please fill the form correctly');
        }
      },
      builder: (context, state) =>
          ModalProgressHUD(
            inAsyncCall: state is SignUpLoadingState,
            child: Scaffold(
              body: Form(
                key: authCubit.signUpFormKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1,),
                    const textWidget(text: "Registration"),
                    SizedBox(height: size.height * 0.1,),
                    const TextFieldEmail(
                        hintText: "Enter Your Name", lableText: "Name"),
                    const SizedBox(height: 32,),
                    TextFieldEmail(hintText: "eamail@gmail.com",
                      lableText: "Email",
                      onChanged: (email) {
                        authCubit.email = email;
                      },),
                    const SizedBox(height: 32,),
                    TextFieldPassword(
                      lableText: "Password", onChanged: (password) {
                      authCubit.password = password;
                    },),
                    const SizedBox(height: 32,),
                    TextFieldPassword(
                      lableText: "Confirm Password", onChanged: (password) {
                      authCubit.password = password;
                    },),
                    SizedBox(height: size.height * 0.08,),
                    IconWidget(
                      size: size,
                      text: "Sign Up",
                      onTap: () async {
                        if (authCubit.signUpFormKey.currentState!.validate()) {
                          await authCubit.signUp();
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.08,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
          ),
    );
  }

  void showSnakBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),),);
  }
}
