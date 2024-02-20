import 'package:chat_setup_app/controller/chat_cubit/chat_cubit_state.dart';
import 'package:chat_setup_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/constant.dart';

class ChatCubit extends Cubit<ChatState>{
  ChatCubit():super(ChatInitialState());
  CollectionReference message =
  FirebaseFirestore.instance.collection(kMessageCollection);
  sendMessage({required String messages,required String email}) {
    message.add(
        {
          kMessage: messages,
          kCreatedAt: DateTime.now(),
          kId:email,
        }
    );
  }

  getMessage(){
    message.orderBy(kCreatedAt,descending: true,).snapshots().listen((event) {
      List<Message> messageList=[];
      for(var doc in event.docs){
        messageList.add(Message.fromJson(doc),);
      }
      emit(ChatSuccessState(messages: messageList),);
    });
  }
}