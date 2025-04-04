import 'package:flutter/material.dart';
import 'package:pulse/chat_screen.dart';
import 'package:pulse/form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Chat',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: ChatScreen(),
      home: FormPage(),
    );
  }
}
