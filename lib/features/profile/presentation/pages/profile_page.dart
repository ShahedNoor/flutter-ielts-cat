import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_cat/components/loading_indicator.dart';
import 'package:ielts_cat/injection_container.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ProfileBloc>()..add(LoadProfile(currentUser?.email ?? '')),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text("P R O F I L E"),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: LoadingIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is ProfileLoaded) {
              final user = state.user;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(25.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: const Icon(Icons.person, size: 64),
                    ),
                    const SizedBox(height: 25.0),
                    Text(
                      user.username ?? 'No Username',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("Initializing..."));
            }
          },
        ),
      ),
    );
  }
}
