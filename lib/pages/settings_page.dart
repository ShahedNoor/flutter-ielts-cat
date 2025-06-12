import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/light_mode.dart';
import '../theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 12.0,
              left: 12.0,
              right: 12.0,
            ),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Text("Dark Mode"),
              trailing: CupertinoSwitch(
                value:
                    Provider.of<ThemeProvider>(context).themeData == lightMode
                        ? false
                        : true,
                onChanged: (_) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
