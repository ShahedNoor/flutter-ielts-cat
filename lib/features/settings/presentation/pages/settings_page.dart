import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: myListTile(context),
          ),
        ],
      ),
    );
  }

  Widget myListTile(BuildContext context) {
    // Watch the Cubit to get the current state for the switch value
    final themeMode = context.watch<ThemeCubit>().state.brightness;

    return ListTile(
      title: const Text("Dark Mode"),
      trailing: CupertinoSwitch(
        value: themeMode == Brightness.dark,
        onChanged: (_) {
          // Read the Cubit to trigger the event (method call)
          context.read<ThemeCubit>().toggleTheme();
        },
      ),
    );
  }
}
