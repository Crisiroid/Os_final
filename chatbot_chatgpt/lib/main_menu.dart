import 'package:flutter/material.dart';

import 'chat_page.dart';

class MainMenuPage extends StatefulWidget {
  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  List<ChatThread> chatThreads = [];
  int threadCount = 0;

  void createNewThread() {
    setState(() {
      threadCount++;
      chatThreads.add(ChatThread(threadNumber: threadCount, chatMessages: []));
    });
  }

  void closeThread(int threadNumber) {
    setState(() {
      chatThreads.removeWhere((thread) => thread.threadNumber == threadNumber);
    });
  }

  void resumeThread(ChatThread chatThread) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          chatThread: chatThread,
          onClose: () => closeThread(chatThread.threadNumber),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
      body: ListView.builder(
        itemCount: chatThreads.length,
        itemBuilder: (context, index) {
          ChatThread chatThread = chatThreads[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                'Thread ${chatThread.threadNumber}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Messages: ${chatThread.chatMessages.length}'),
              onTap: () => resumeThread(chatThread),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewThread,
        child: const Icon(Icons.add),
      ),
    );
  }
}
