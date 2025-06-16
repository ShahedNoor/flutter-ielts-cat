import 'package:flutter/material.dart';
import 'package:ielts_cat/components/my_button.dart';

import 'my_textfield.dart';

enum ScoreType { listening, generalReading, academicReading }

class IndividualScoreCalculatorCard extends StatefulWidget {
  final String title;
  final ScoreType type;

  const IndividualScoreCalculatorCard({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  State<IndividualScoreCalculatorCard> createState() =>
      _IndividualScoreCalculatorCardState();
}

class _IndividualScoreCalculatorCardState
    extends State<IndividualScoreCalculatorCard> {
  final TextEditingController _inputController = TextEditingController();
  String result = '';
  final _formKey = GlobalKey<FormState>();

  void calculateBandScore() {
    final int? rawScore = int.tryParse(_inputController.text);

    if (rawScore == null || rawScore < 0 || rawScore > 40) {
      setState(() => result = "Invalid input");
      return;
    }

    double band;

    switch (widget.type) {
      case ScoreType.listening:
        band = _getListeningBand(rawScore);
        break;
      case ScoreType.generalReading:
        band = _getGeneralReadingBand(rawScore);
        break;
      case ScoreType.academicReading:
        band = _getAcademicReadingBand(rawScore);
        break;
    }

    setState(() {
      result = band.toStringAsFixed(1);
    });
  }

  void resetForm() {
    _inputController.clear();
    setState(() {
      result = '';
    });
  }

  double _getListeningBand(int score) {
    if (score >= 39) return 9.0;
    if (score >= 37) return 8.5;
    if (score >= 35) return 8.0;
    if (score >= 32) return 7.5;
    if (score >= 30) return 7.0;
    if (score >= 26) return 6.5;
    if (score >= 23) return 6.0;
    if (score >= 18) return 5.5;
    if (score >= 16) return 5.0;
    if (score >= 13) return 4.5;
    if (score >= 10) return 4.0;
    if (score >= 7) return 3.5;
    if (score >= 4) return 3.0;
    if (score >= 3) return 2.5;
    if (score >= 2) return 2.0;
    if (score >= 1) return 1.0;
    return 0.0;
  }

  double _getGeneralReadingBand(int score) {
    if (score >= 40) return 9.0;
    if (score >= 39) return 8.5;
    if (score >= 37) return 8.0;
    if (score >= 36) return 7.5;
    if (score >= 34) return 7.0;
    if (score >= 32) return 6.5;
    if (score >= 30) return 6.0;
    if (score >= 27) return 5.5;
    if (score >= 23) return 5.0;
    if (score >= 19) return 4.5;
    if (score >= 15) return 4.0;
    if (score >= 12) return 3.5;
    if (score >= 7) return 3.0;
    if (score >= 5) return 2.5;
    if (score >= 2) return 2.0;
    if (score >= 1) return 1.0;
    return 0.0;
  }

  double _getAcademicReadingBand(int score) {
    if (score >= 39) return 9.0;
    if (score >= 37) return 8.5;
    if (score >= 35) return 8.0;
    if (score >= 33) return 7.5;
    if (score >= 30) return 7.0;
    if (score >= 27) return 6.5;
    if (score >= 23) return 6.0;
    if (score >= 19) return 5.5;
    if (score >= 15) return 5.0;
    if (score >= 13) return 4.5;
    if (score >= 10) return 4.0;
    if (score >= 7) return 3.5;
    if (score >= 4) return 3.0;
    if (score >= 3) return 2.5;
    if (score >= 2) return 2.0;
    if (score >= 1) return 1.0;
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                widget.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              MyTextField(
                hintText: "Raw Score (0-40)",
                labelText: "Raw Score (0-40)",
                obscureText: false,
                controller: _inputController,
                validator: (value) {
                  final num = int.tryParse(value ?? '');
                  if (num == null || num < 0 || num > 40) {
                    return 'Enter a valid score (0-40)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    text: "Calculate",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        calculateBandScore();
                      }
                    },
                  ),
                  MyButton(text: "Reset", onTap: resetForm),
                ],
              ),
              const SizedBox(height: 16),
              if (result.isNotEmpty)
                Text(
                  "Band Score: $result",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
