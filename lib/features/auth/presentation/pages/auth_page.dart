import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_cat/gen/assets.gen.dart';

import 'package:ielts_cat/features/home/presentation/pages/home_page.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Authenticated) {
            return HomePage();
          } else if (state is Unauthenticated || state is AuthError) {
            return const LoginOrRegister();
          } else {
            // Loading state
            final width = MediaQuery.sizeOf(context).width;
            return Center(
              child: Assets.animations.catLoading.image(width: width / 3),
            );
          }
        },
      ),
    );
  }
}
