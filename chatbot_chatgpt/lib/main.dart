// ignore_for_file: prefer_const_constructors

import 'package:chatbot_chatgpt/choose_chat.dart';
import 'package:flutter/material.dart';

void main() => runApp(mainApp());

class mainApp extends StatelessWidget {
  const mainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ChooseChatType(),
    );
  }
}
