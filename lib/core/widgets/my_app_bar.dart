import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  // Fetch current user data
  Future<Map<String, dynamic>> getCurrentUserData() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) throw Exception("No user logged in");

    final doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.email)
        .get();

    if (!doc.exists || doc.data() == null) {
      throw Exception("No user data found");
    }

    return doc.data()!;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.build_circle),
        onPressed: () => Scaffold.of(context).openDrawer(),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      title: FutureBuilder<Map<String, dynamic>>(
        future: getCurrentUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return const SizedBox(
              height: 50,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            // Error state
            return const Text("Error loading user");
          } else if (!snapshot.hasData) {
            return const Text("No user data");
          } else {
            final user = snapshot.data!;
            final username = user['username'] ?? "No Name";
            final profileImage =
                user['profilePicture']; // store URL in Firestore
            return InkWell(
              onTap: () => Navigator.pushNamed(context, "/profilePage"),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 10),
                    Text(username, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 10),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: profileImage != null
                            ? Image.network(profileImage, fit: BoxFit.cover)
                            : const Icon(Icons.person, size: 20), // default
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            );
          }
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.circle_notifications,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
