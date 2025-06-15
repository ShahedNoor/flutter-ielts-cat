import 'package:flutter/material.dart';
import 'package:ielts_cat/components/overall_band_score_calculator_card.dart';

import '../components/individual_score_calculator_card.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          IndividualScoreCalculatorCard(
            title: "Listening Score Calculator",
            type: ScoreType.listening,
          ),
          SizedBox(height: 16),
          IndividualScoreCalculatorCard(
            title: "General Reading Score Calculator",
            type: ScoreType.generalReading,
          ),
          SizedBox(height: 16),
          IndividualScoreCalculatorCard(
            title: "Academic Reading Score Calculator",
            type: ScoreType.academicReading,
          ),
          SizedBox(height: 16),
          OverallBandScoreCalculatorCard(),
        ],
      ),
    );
  }
}
