import 'package:chatbot_chatgpt/chat_page.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int threadNumber = 0;

  void incrementThreadNumber() {
    setState(() {
      threadNumber++;
    });
  }

  void decrementThreadNumber() {
    setState(() {
      threadNumber--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Thread Number: $threadNumber',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                incrementThreadNumber();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      threadNumber: threadNumber,
                      onClose: decrementThreadNumber,
                    ),
                  ),
                );
              },
              child: Text('Enter Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
