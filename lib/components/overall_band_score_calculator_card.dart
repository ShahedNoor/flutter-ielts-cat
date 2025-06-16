import 'package:flutter/material.dart';
import 'package:ielts_cat/components/my_button.dart';

class OverallBandScoreCalculatorCard extends StatefulWidget {
  const OverallBandScoreCalculatorCard({super.key});

  @override
  State<OverallBandScoreCalculatorCard> createState() =>
      _OverallBandScoreCalculatorCardState();
}

class _OverallBandScoreCalculatorCardState
    extends State<OverallBandScoreCalculatorCard> {
  final List<double> _bandOptions = [
    0,
    0.5,
    1,
    1.5,
    2,
    2.5,
    3,
    3.5,
    4,
    4.5,
    5,
    5.5,
    6,
    6.5,
    7,
    7.5,
    8,
    8.5,
    9,
  ];

  double listening = -1;
  double reading = -1;
  double writing = -1;
  double speaking = -1;
  String result = '';

  void calculateOverallScore() {
    final scores = [listening, reading, writing, speaking];
    if (scores.any((score) => score == -1)) {
      setState(() => result = 'Please select a score for all sections');
      return;
    }
    if (scores.any((score) => score > 9.0)) {
      setState(() => result = 'Band scores cannot exceed 9.0');
      return;
    }

    final average = scores.reduce((a, b) => a + b) / 4;
    // Round to nearest 0.5 or whole number as per IELTS rules
    double rounded;
    final decimal = average - average.floor();
    if (decimal < 0.25) {
      rounded = average.floorToDouble();
    } else if (decimal < 0.75) {
      rounded = average.floorToDouble() + 0.5;
    } else {
      rounded = average.ceilToDouble();
    }

    setState(() {
      result = 'Overall Band Score: ${rounded.toStringAsFixed(1)}';
    });
  }

  void reset() {
    setState(() {
      listening = reading = writing = speaking = -1;
      result = '';
    });
  }

  Widget _buildDropdown(
    String label,
    double value,
    void Function(double?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 6),
        DropdownButtonFormField<double>(
          value: value != -1 ? value : null,
          items: _bandOptions
              .map((v) => DropdownMenuItem(value: v, child: Text(v.toString())))
              .toList(),
          onChanged: onChanged,
          hint: const Text("Select"),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Overall Band Score Calculator",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildDropdown(
              "Listening",
              listening,
              (val) => setState(() => listening = val ?? -1),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              "Reading",
              reading,
              (val) => setState(() => reading = val ?? -1),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              "Writing",
              writing,
              (val) => setState(() => writing = val ?? -1),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              "Speaking",
              speaking,
              (val) => setState(() => speaking = val ?? -1),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(text: "Calculate", onTap: calculateOverallScore),
                MyButton(text: "Reset", onTap: reset),
              ],
            ),
            const SizedBox(height: 20),
            if (result.isNotEmpty)
              Text(
                result,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
