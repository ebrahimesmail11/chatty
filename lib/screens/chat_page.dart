

import 'package:chat_setup_app/const/constant.dart';
import 'package:chat_setup_app/model/message.dart';
import 'package:chat_setup_app/widget/message_chat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String id = "ChatPage";
  CollectionReference message =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(kCreatedAt,descending: true,).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
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
                  Text(
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
                  child: ListView.builder(
                    reverse: true,
                      controller: _scrollController,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email?MessageChat(
                          messages: messageList[index],
                        ):MessageChatForFriend(messages: messageList[index]);
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    controller: controller,
                    onSubmitted:
                        (value) {
                      message
                          .add(
                          {
                            kMessage: value,
                            kCreatedAt: DateTime.now(),
                            kId:email,
                          }
                      );
                      controller.clear();
                      _scrollController.animateTo(
                          0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: (){
                          message.add(
                            {
                              kMessage:controller.text,
                              kCreatedAt: DateTime.now(),
                              kId:email,
                            }
                          );
                          controller.clear();
                          _scrollController.animateTo(
                            0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                          child: Icon(Icons.send_outlined),
                      ),
                      hintText: "Send Message",
                      suffixIconColor: kSendColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(width: 1, color: kSendColor)),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}