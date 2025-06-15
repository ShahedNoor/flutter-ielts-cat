import 'package:flutter/material.dart';
import 'package:ielts_cat/components/my_bottom_app_bar.dart';
import '../components/my_drawer.dart';
import '../database/firestore_database.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
      bottomNavigationBar: MyBottomAppBar(),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
