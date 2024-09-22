import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../components/my_list_tile.dart';
import '../components/my_post_button.dart';
import '../components/my_textfield.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text("W A L L"),
      ),
      drawer: const MyDrawer(),
      // body: Column(
      //   children: [
      //     // Text field for user to type wall post
      //     Padding(
      //       padding: const EdgeInsets.all(25.0),
      //       child: Row(
      //         children: [
      //           Expanded(
      //             child: MyTextField(
      //               hintText: "Say something...",
      //               obscureText: false,
      //               controller: newPostController,
      //             ),
      //           ),
      //
      //           // Post button
      //           MyPostButton(
      //             onTap: postMessage,
      //           ),
      //         ],
      //       ),
      //     ),
      //
      //     // Posts
      //     StreamBuilder(
      //       stream: database.getPostsStream(),
      //       builder: (context, snapshot) {
      //         // Show circular progress indicator
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const Expanded(
      //             child: Center(
      //               child: CircularProgressIndicator(),
      //             ),
      //           );
      //         }
      //
      //         // Get all posts
      //         final posts = snapshot.data!.docs;
      //
      //         // If no data
      //         if (snapshot.data == null || posts.isEmpty) {
      //           return const Expanded(
      //             child: Center(
      //               child: Padding(
      //                 padding: EdgeInsets.all(25.0),
      //                 child: Text(
      //                     "No posts found in the database! \nPost something..."),
      //               ),
      //             ),
      //           );
      //         }
      //
      //         // Return a list
      //         return Expanded(
      //           child: ListView.builder(
      //             itemCount: posts.length,
      //             itemBuilder: (context, index) {
      //               // Get each individual post
      //               final post = posts[index];
      //
      //               // Get data from each post
      //               String message = post['PostMessage'];
      //               String userEmail = post['UserEmail'];
      //               // Timestamp timestamp = post['TimeStamp'];
      //
      //               // Return a list tile
      //               return MyListTile(title: message, subtitle: userEmail);
      //             },
      //           ),
      //         );
      //       },
      //     )
      //   ],
      // ),
    );
  }
}
