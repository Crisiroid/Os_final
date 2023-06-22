import 'package:flutter/material.dart';
import 'main_menu.dart';

class ChatPage extends StatefulWidget {
  final List<ChatThread> chatThreads;
  final ChatThread chatThread;
  final Function() onClose;

  ChatPage(
      {required this.chatThreads,
      required this.chatThread,
      required this.onClose});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> chatMessages = [];
  TextEditingController messageController = TextEditingController();

  void addMessage(String message) {
    setState(() {
      widget.chatThreads.forEach((thread) {
        if (thread.threadNumber != widget.chatThread.threadNumber) {
          thread.chatMessages.add('${widget.chatThread.user}: $message');
        }
      });
      chatMessages.add(message);
      String response = generateResponse(message);
      chatMessages.add(response);
    });
    messageController.clear();
  }

  String generateResponse(String message) {
    if (message.toLowerCase() == 'hello') {
      return 'Hello! How can I assist you?';
    } else if (message.toLowerCase() == 'how are you?') {
      return 'I am doing well, thank you!';
    } else if (message.toLowerCase() == 'what is your name?') {
      return 'My name is ChatBot.';
    } else if (message.toLowerCase() == 'what can you do?') {
      return 'I can answer your questions and provide assistance.';
    } else if (message.toLowerCase() == 'tell me a joke') {
      return 'Why don’t scientists trust atoms? Because they make up everything!';
    } else if (message.toLowerCase() == 'where are you located?') {
      return 'I exist in the digital realm, so I am everywhere and nowhere at the same time.';
    } else if (message.toLowerCase() == 'thank you') {
      return 'You\'re welcome! If you have any more questions, feel free to ask.';
    } else if (message.toLowerCase() == 'how can I contact you?') {
      return 'You can reach out to me via email at chatbot@example.com.';
    } else if (message.toLowerCase() == 'what is the meaning of life?') {
      return 'The meaning of life is subjective and can vary for each individual.';
    } else if (message.toLowerCase() == 'bye') {
      return 'Goodbye! Take care!';
    } else {
      return "I'm sorry, I didn't understand that.";
    }
  }

  @override
  void initState() {
    super.initState();
    chatMessages = widget.chatThread.chatMessages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page - Thread ${widget.chatThread.threadNumber}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.chatThreads.length,
              itemBuilder: (context, index) {
                ChatThread chatThread = widget.chatThreads[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Thread ${chatThread.threadNumber} - ${chatThread.user}:'),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: chatThread.chatMessages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(chatThread.chatMessages[index]),
                        );
                      },
                    ),
                  ],
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
