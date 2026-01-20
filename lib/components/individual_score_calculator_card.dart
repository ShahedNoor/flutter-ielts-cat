import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_cat/components/my_button.dart';
import 'package:ielts_cat/features/calculator/presentation/cubit/calculator_cubit.dart';
import 'package:ielts_cat/injection_container.dart';

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
  final _formKey = GlobalKey<FormState>();

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
            color: Theme.of(context).colorScheme.primary,
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
                              context
                                  .read<CalculatorCubit>()
                                  .calculateIndividual(
                                    widget.type,
                                    _inputController.text,
                                  );
                            }
                          },
                        ),
                        MyButton(
                          text: "Reset",
                          onTap: () {
                            _inputController.clear();
                            context.read<CalculatorCubit>().reset();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<CalculatorCubit, CalculatorState>(
                      builder: (context, state) {
                        if (state is CalculatorResult) {
                          return Text(
                            "Band Score: ${state.result}",
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
            ),
          );
        },
      ),
    );
  }
}
