import 'package:chat_setup_app/controller/chat_cubit/chat_cubit.dart';
import 'package:chat_setup_app/controller/cubit/auth_cubit.dart';
import 'package:chat_setup_app/firebase_options.dart';
import 'package:chat_setup_app/screens/chat_page.dart';
import 'package:chat_setup_app/screens/login_page.dart';
import 'package:chat_setup_app/screens/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}
class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create:  (context) => AuthCubit(),),
        BlocProvider(
          create: (context) => ChatCubit(),),
      ],
      child: MaterialApp(
        routes:{
          LoginPage.id:(context)=>LoginPage(),
          RegisterPage.id:(context)=>RegisterPage(),
          ChatPage.id:(context)=>ChatPage(),

        },
        initialRoute: LoginPage.id,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
