
import 'package:chat_setup_app/model/message.dart';
import 'package:flutter/material.dart';

class MessageChat extends StatelessWidget {
  const MessageChat({
    super.key,
    required this.messages,
  });
final Message messages;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18,),
          Container(
            padding: EdgeInsets.only(bottom: 32,top: 32,right: 32,left: 16),
            // margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                ),
                color: Colors.deepPurple
            ),
            child: Text(messages.text,style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}






class MessageChatForFriend extends StatelessWidget {
  const MessageChatForFriend({
    super.key,
    required this.messages,
  });
  final Message messages;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 18,),
             Container(
              padding: EdgeInsets.only(bottom: 32,top: 32,right: 32,left: 16),
              // margin: EdgeInsets.only(left: 16,top: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                    topLeft: Radius.circular(32),
                  ),
                  color: Colors.indigoAccent,
              ),
              child: Text(messages.text,style: TextStyle(color: Colors.white),),
            ),

        ],
      ),
    );
  }
}