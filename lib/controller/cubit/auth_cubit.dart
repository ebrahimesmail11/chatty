import 'package:chat_setup_app/controller/cubit/auth_cubit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit():super(LogInInitialState());
  GlobalKey<FormState> logInFormKey=GlobalKey();
  GlobalKey<FormState> signUpFormKey=GlobalKey();

  String? email;
  String? password;
  Future<void> logIn()async{
    if(logInFormKey.currentState!.validate()){
      emit(LogInLoadingState());
      try{
        await loginValidate();
         emit(LogInSuccessState());
        // showSnakBar(context, message: "Successed");
        // Navigator.pushNamed(context, ChatPage.id,arguments: email);
      }on FirebaseAuthException catch (e){
        if(e.code=="user-not-found"){
          emit(LogInFailureState( "No user found for that email"),);
          // showSnakBar(context,message: "No User found for that email");
        }else if(e.code == "wrong-password"){
          emit(LogInFailureState( 'Wrong password provided for that user.'),);
          // showSnakBar(context, message: "Wrong password provided for that user .");
        }else{
          emit(LogInFailureState('there are some thing went wrong with your email or password.'),);
        }
      }catch(e){
        emit(LogInFailureState(e.toString(),),);
      }
    }
  }
  Future<void> signUp()async{
    if(signUpFormKey.currentState!.validate()){
      emit(SignUpLoadingState());
      try {
         await signUpValidate();
         emit(SignUpSuccessState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(SignUpFailureState( "The password provided is too weak."),);
        } else if (e.code == 'email-already-in-use') {
          emit(SignUpFailureState( 'The account already exists for that email.'),);
        }else if (e.code == 'Invalid-email') {
          emit(SignUpFailureState( 'The email is invalid.'),);
        } else{
          emit(SignUpFailureState( e.code),);
        }
      } catch (e) {
        emit(SignUpFailureState(e.toString(),),);
      }
    }
  }

  Future<void> signUpValidate() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: email!,
     password: password!,);
  }
  Future<void> loginValidate() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!);
  }
}