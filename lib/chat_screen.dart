import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      String userMessage = messageController.text;
      setState(() {
        messages.insert(0, {'text': userMessage, 'sender': 'user'});
      });
      messageController.clear();

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8000/chat'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "prompt": userMessage,
            "max_length": 100, // Adjust as needed
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            messages.insert(0, {
              'text': data['generated_text'],
              'sender': 'server',
            });
          });
        } else {
          print('Failed to fetch response: ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  void resetMessages() {
    setState(() {
      messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff095D7E),
        title: const Text(
          'Pulse',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]['sender'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.teal[700] : Colors.teal[100],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                        bottomLeft:
                            isUser ? const Radius.circular(10) : Radius.zero,
                        bottomRight:
                            isUser ? Radius.zero : const Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      messages[index]['text']!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 100,
            color: Color(0xff095D7E),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 4, bottom: 4, right: 8),
                    child: ElevatedButton(
                      onPressed: resetMessages,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        elevation: 0,
                      ),
                      child: Icon(Icons.refresh, color: Colors.white, size: 26),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Prompt...',
                        filled: true,
                        fillColor: Colors.green[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  FloatingActionButton(
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.send, color: Colors.white),
                    onPressed: sendMessage,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
