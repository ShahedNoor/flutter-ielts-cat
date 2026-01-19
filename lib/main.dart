import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_cat/gen/assets.gen.dart';
import 'package:ielts_cat/injection_container.dart';

import 'features/auth/presentation/pages/auth_page.dart';
import 'features/auth/presentation/pages/login_or_register_page.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/settings/presentation/cubit/theme_cubit.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(Assets.animations.catLoading.provider(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(AuthAppStarted())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return FutureBuilder<FirebaseApp>(
            future: _firebaseInitFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                final width = MediaQuery.sizeOf(context).width;

                return MaterialApp(
                  title: "IELTS Cat",
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  // darkTheme is explicitly handled by the Cubit emitting the correct ThemeData
                  home: Scaffold(
                    body: Center(
                      child: Assets.animations.catLoading.image(
                        width: width / 3,
                      ),
                    ),
                  ),
                );
              }

              return MaterialApp(
                title: "IELTS Cat",
                debugShowCheckedModeBanner: false,
                theme: theme,
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
      ),
    );
  }
}
