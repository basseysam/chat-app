import 'package:chat_app/ui/screens/chat_details_screen.dart';
import 'package:chat_app/ui/screens/home_page.dart';
import 'package:chat_app/utils/database_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  final DatabaseService _dbService = DatabaseService.dbInstance;
  _dbService.createDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        ChatDetailPage.routeName: (ctx) => const ChatDetailPage(),
      },
    );
  }
}
