import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Drawer header with logo
              DrawerHeader(
                child: Image.asset("assets/animations/maoew.gif"),
              ),

              const SizedBox(
                height: 25.0,
              ),

              // Home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("H O M E"),
                  onTap: () {
                    // If already in home page then just pop the context
                    Navigator.pop(context);
                  },
                ),
              ),

              // Profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("P R O F I L E"),
                  onTap: () {
                    // Pop the context
                    Navigator.pop(context);

                    // Navigate to profile page
                    Navigator.pushNamed(context, '/profilePage');
                  },
                ),
              ),

              // Settings tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("S E T T I N G S"),
                  onTap: () {
                    // Pop the context
                    Navigator.pop(context);

                    // Navigate to profile page
                    Navigator.pushNamed(context, '/settingsPage');
                  },
                ),
              ),
            ],
          ),

          // Logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 25.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: () {
                // Pop the context
                Navigator.pop(context);

                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
