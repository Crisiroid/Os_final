import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatGptPage extends StatefulWidget {
  @override
  _ChatGptPageState createState() => _ChatGptPageState();
}

class _ChatGptPageState extends State<ChatGptPage> {
  TextEditingController messageController = TextEditingController();
  List<String> chatMessages = [];

  Future<String> getChatbotResponse(String message) async {
    String apiUrl = 'https://api.openai.com/v1/chat/completions';
    String apiKey = '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';

    Map<String, dynamic> requestBody = {
      'messages': [
        {'role': 'system', 'content': 'You are a helpful assistant.'},
        {'role': 'user', 'content': message},
      ],
      'model': 'gpt-3.5-turbo',
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    print('API response: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String chatbotResponse = data['choices'][0]['message']['content'];
      return chatbotResponse;
    } else {
      throw Exception('Failed to fetch chatbot response');
    }
  }

  Future<void> addMessage(String message) async {
    setState(() {
      chatMessages.add('User: $message');
    });

    String chatbotResponse = await getChatbotResponse(message);

    setState(() {
      chatMessages.add('Chatbot: $chatbotResponse');
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    String message = messageController.text.trim();
                    if (message.isNotEmpty) {
                      await addMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
