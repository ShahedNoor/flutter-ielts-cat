import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth_page.dart';
import 'auth/login_or_register_or_reset_password.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'theme/dark_mode.dart';
import 'theme/theme_provider.dart';

import 'package:ielts_cat/gen/assets.gen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<FirebaseApp> _firebaseInitFuture;

  @override
  void initState() {
    super.initState();
    _firebaseInitFuture = Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Precache loading gif to make loading smoother
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(Assets.animations.catLoading.provider(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return FutureBuilder<FirebaseApp>(
          future: _firebaseInitFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              final width = MediaQuery.sizeOf(context).width;

              return MaterialApp(
                title: "IELTS Cat",
                debugShowCheckedModeBanner: false,
                theme: themeProvider.themeData,
                darkTheme: darkMode,
                home: Scaffold(
                  body: Center(
                    child: Assets.animations.catLoading.image(width: width / 3),
                  ),
                ),
              );
            }

            return MaterialApp(
              title: "IELTS Cat",
              debugShowCheckedModeBanner: false,
              theme: themeProvider.themeData,
              darkTheme: darkMode,
              home: const AuthPage(),
              routes: {
                "/loginOrRegister": (context) => const LoginOrRegister(),
                "/homePage": (context) => HomePage(),
                "/profilePage": (context) => ProfilePage(),
                "/settingsPage": (context) => SettingsPage(),
              },
            );
          },
        );
      },
    );
  }
}
// 