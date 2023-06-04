import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final int threadNumber;
  final Function() onClose;

  ChatPage({required this.threadNumber, required this.onClose});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> chatMessages = [];
  TextEditingController messageController = TextEditingController();

  void addMessage(String message) {
    setState(() {
      chatMessages.add(message);
    });
    messageController.clear();
  }

  void processUserInput(String input) {
    String lowercaseInput = input.toLowerCase();

    if (lowercaseInput.contains('hello')) {
      addMessage('Hello! How can I assist you?');
    } else if (lowercaseInput.contains('how are you')) {
      addMessage(
          'I am a chatbot, so I do not have feelings, but thank you for asking!');
    } else if (lowercaseInput.contains('who are you')) {
      addMessage(
          'I am a chatbot. My purpose is to assist and provide information.');
    } else {
      addMessage('Sorry, I did not understand your message.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page - Thread ${widget.threadNumber}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatMessages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = messageController.text.trim();
                    if (message.isNotEmpty) {
                      addMessage(message);
                      processUserInput(message);
                    }
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: widget.onClose,
            child: Text('Close Thread'),
          ),
        ],
      ),
    );
  }
}
