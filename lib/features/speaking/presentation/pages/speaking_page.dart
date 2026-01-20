import 'package:flutter/material.dart';
import 'package:ielts_cat/components/my_button.dart';

class SpeakingPage extends StatefulWidget {
  const SpeakingPage({super.key});

  @override
  State<SpeakingPage> createState() => _SpeakingPageState();
}

class _SpeakingPageState extends State<SpeakingPage> {
  String selectedLevel = "Rookie";
  // default selection
  Widget _buildLevelButton(String level) {
    return MyButton(
      text: level,
      isSelected: selectedLevel == level,
      onTap: () {
        setState(() {
          selectedLevel = level;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Banner image
          // I will add this later

          // Partner lever
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Text(
                  "Please Select Your Level of Speaking!",
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLevelButton("Rookie"),
                    _buildLevelButton("Pro Player"),
                    _buildLevelButton("Legend"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
