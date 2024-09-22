import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/auth_page.dart';
import 'auth/login_or_register.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/user_page.dart';
import 'theme/dark_mode.dart';
import 'theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Future to hold Firebase initialization
  Future<FirebaseApp> _initializeFirebase() async {
    return Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Widget build(BuildContext context) {
    // Media query
    final width = MediaQuery.sizeOf(context).width;

    return FutureBuilder(
      // Wait for Firebase to initialize
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        // If Firebase is still initializing, show loading spinner
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            title: "IELTS's Cat",
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            home: Scaffold(
              body: Center(
                child: Image.asset(
                  "assets/images/cat_loading.gif",
                  width: width / 3,
                ),
              ),
            ),
          );
        }
        // Once Firebase is initialized, show the app
        return MaterialApp(
          title: "IELTS's Cat",
          debugShowCheckedModeBanner: false,
          home: const AuthPage(),
          theme: lightMode,
          darkTheme: darkMode,
          routes: {
            "/loginOrRegister": (context) => const LoginOrRegister(),
            "/homePage": (context) => HomePage(),
            "/profilePage": (context) => ProfilePage(),
            "/userPage": (context) => const UserPage(),
          },
        );
      },
    );
  }
}
