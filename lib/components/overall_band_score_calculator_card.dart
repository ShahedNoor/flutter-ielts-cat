import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_cat/components/my_button.dart';
import 'package:ielts_cat/features/band_calculator/presentation/cubit/calculator_cubit.dart';
import 'package:ielts_cat/injection_container.dart';

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

  void reset(BuildContext context) {
    setState(() {
      listening = reading = writing = speaking = -1;
    });
    context.read<CalculatorCubit>().reset();
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
        InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<double>(
              value: value != -1 ? value : null,
              items: _bandOptions
                  .map(
                    (v) =>
                        DropdownMenuItem(value: v, child: Text(v.toString())),
                  )
                  .toList(),
              onChanged: onChanged,
              hint: const Text("Select"),
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<CalculatorCubit>(),
      child: Builder(
        builder: (context) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            color: theme.colorScheme.primary,
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
                      MyButton(
                        text: "Calculate",
                        onTap: () {
                          context.read<CalculatorCubit>().calculateOverall([
                            listening,
                            reading,
                            writing,
                            speaking,
                          ]);
                        },
                      ),
                      MyButton(text: "Reset", onTap: () => reset(context)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<CalculatorCubit, CalculatorState>(
                    builder: (context, state) {
                      if (state is CalculatorResult) {
                        return Text(
                          state.result,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      } else if (state is CalculatorError) {
                        return Text(
                          state.message,
                          style: TextStyle(color: Colors.red),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
