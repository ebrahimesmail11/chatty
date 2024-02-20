

import 'package:chat_setup_app/const/constant.dart';
import 'package:chat_setup_app/controller/chat_cubit/chat_cubit.dart';
import 'package:chat_setup_app/controller/chat_cubit/chat_cubit_state.dart';
import 'package:chat_setup_app/model/message.dart';
import 'package:chat_setup_app/widget/message_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/cubit/auth_cubit.dart';

class ChatPage extends StatelessWidget {
  static String id = "ChatPage";
List <Message> messageList=[];
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    ChatCubit chatCubit =BlocProvider.of<ChatCubit>(context);
    authCubit.email = ModalRoute
        .of(context)!
        .settings
        .arguments as String?;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text(
              "Chatty",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit,ChatState>(
              listener: (context, state) {
                if(state is ChatSuccessState){
                  messageList=state.messages;
                }
              },
              builder:(context,state)=> ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                     return messageList[index].id == authCubit.email ? MessageChat(
                       messages: messageList[index],
                     ) : MessageChatForFriend(messages: messageList[index]);
                  }),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              controller: controller,
              onSubmitted:
                  (value) {
                chatCubit.sendMessage(messages: value, email: authCubit.email.toString());
                // message
                //     .add(
                //     {
                //       kMessage: value,
                //       kCreatedAt: DateTime.now(),
                //       kId: authCubit.email,
                //     }
                // );
                controller.clear();
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    chatCubit.sendMessage(messages: controller.text, email: authCubit.email.toString());
                    // message.add(
                    //     {
                    //       kMessage: controller.text,
                    //       kCreatedAt: DateTime.now(),
                    //       kId: authCubit.email,
                    //     }
                    // );
                    controller.clear();
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Icon(Icons.send_outlined),
                ),
                hintText: "Send Message",
                suffixIconColor: kSendColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(width: 1, color: kSendColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}