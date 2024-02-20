import 'package:chat_setup_app/const/constant.dart';

class Message{
  final String? text;
  final String? id;
  Message(this.text,this.id);
  factory Message.fromJson(json){
    return Message(json[kMessage],json[kId]);
  }
}