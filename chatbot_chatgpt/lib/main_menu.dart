import 'package:flutter/material.dart';
import 'chat_page.dart';

class ChatThread {
  final int threadNumber;
  final List<String> chatMessages;
  final String user;

  ChatThread(
      {required this.threadNumber,
      required this.chatMessages,
      required this.user});
}

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
      chatThreads.add(ChatThread(
          threadNumber: threadCount,
          chatMessages: [],
          user: 'User $threadCount'));
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
          chatThreads: chatThreads,
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
                'Thread ${chatThread.threadNumber} - ${chatThread.user}',
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

void main() {
  runApp(MaterialApp(
    title: 'Chat App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MainMenuPage(),
  ));
}
