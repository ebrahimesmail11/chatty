
import 'package:chat_setup_app/controller/chat_cubit/chat_cubit.dart';
import 'package:chat_setup_app/controller/cubit/auth_cubit.dart';
import 'package:chat_setup_app/controller/cubit/auth_cubit_state.dart';
import 'package:chat_setup_app/helper/show_snak_bar.dart';
import 'package:chat_setup_app/screens/chat_page.dart';
import 'package:chat_setup_app/screens/register_page.dart';
import 'package:chat_setup_app/widget/icon_widget.dart';
import 'package:chat_setup_app/widget/text_field_email.dart';
import 'package:chat_setup_app/widget/text_field_password.dart';
import 'package:chat_setup_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String id = "LoginPage";



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogInLoadingState) {
          const CircularProgressIndicator();
        } else if (state is LogInSuccessState) {
          // Navigator.pushNamed(context, ChatPage.id);
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id,arguments: authCubit.email);
        } else if (state is LogInFailureState) {
          showSnakBar(
              context, message: "Wrong password provided for that user .");
          // isLoading=false;
        } else {

        }
      },
      builder: (context, state) =>
          ModalProgressHUD(
            inAsyncCall: state is LogInLoadingState,
            child: Scaffold(
              body: Form(
                key: authCubit.logInFormKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: size.height * 0.1,),
                    const textWidget(text: "Login"),
                    const SizedBox(height: 32,),
                    Image.asset("assets/image.jpg"),
                    const SizedBox(height: 32,),
                    TextFieldEmail(hintText: "eamail@gmail.com",
                        lableText: "Email",
                        onChanged: (email) {
                          authCubit.email = email;
                        }),
                    const SizedBox(height: 32,),
                    TextFieldPassword(
                        lableText: "Password", onChanged: (password) {
                      authCubit.password = password;
                    }),
                    const SizedBox(height: 32,),
                    IconWidget(
                      size: size,
                      text: "Login",
                      onTap: () async {
                        if (authCubit.logInFormKey.currentState!.validate()) {
                          await authCubit.logIn();
                        }
                      },
                    ),
                    const SizedBox(height: 32,),
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
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: const Text(
                            "Sign Up",
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
}

//   Future<void> loginValidate() async {
//      await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email!,
//         password: password!);
//   }
// }
