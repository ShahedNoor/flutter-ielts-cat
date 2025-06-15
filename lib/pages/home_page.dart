import 'package:flutter/material.dart';
import 'package:ielts_cat/components/my_bottom_app_bar.dart';
import '../components/my_drawer.dart';
import '../database/firestore_database.dart';
import 'calculator_page.dart';
import 'listening_page.dart';
import 'reading_page.dart';
import 'speaking_page.dart';
import 'writing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // Text field controller
  final TextEditingController newPostController = TextEditingController();

  // Post message
  void postMessage() {
    // Only post message if there is something in the text field
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // Clear the controller
    newPostController.clear();
  }

  int currentPage = 0;

  // List of pages
  final List<Widget> pages = const [
    ListeningPage(),
    ReadingPage(),
    WritingPage(),
    SpeakingPage(),
    CalculatorPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        centerTitle: true,
        title: const Text("IELTS's Cat"),
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: MyBottomAppBar(
        currentIndex: currentPage,
        onTap: onTabTapped,
      ),
      body: pages[currentPage]
      );
  }
}
