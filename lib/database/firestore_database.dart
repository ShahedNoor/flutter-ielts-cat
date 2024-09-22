/*

This database stores posts that users have published in the app.
It is stored in a collection called 'Posts' in firebase.

Each post contains:
  - message
  - email of user
  - timestamp
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // Current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // Get collection of posts form firebase
  final CollectionReference posts =
  FirebaseFirestore.instance.collection('Posts');

  // Post message
  Future<void> addPost(String message) {
    return posts.add(
      {
        'UserEmail': user!.email,
        'PostMessage': message,
        'TimeStamp': Timestamp.now(),
      },
    );
  }

  // Read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postsStream;
  }
}
