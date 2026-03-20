import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts_cat/core/theme/ielts_colors.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final Map<String, int> _selected = {};
  bool _showResults = false;

  final Map<String, int> _correct = const {'q1': 1, 'q2': 1};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(
            tag: 'Academic · Passage 1',
            title: 'Reading',
            badge: '20 min',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: IeltsColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: IeltsColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Age of Urban Farming',
                    style: GoogleFonts.fraunces(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      style: GoogleFonts.dmSans(
                        fontSize: 13.5,
                        height: 1.75,
                        color: const Color(0xFF3A3630),
                      ),
                      children: const [
                        TextSpan(
                          text:
                              'Urban agriculture — the practice of cultivating food within city boundaries — has experienced a remarkable resurgence over the past two decades. Once dismissed as a ',
                        ),
                        TextSpan(
                          text: 'nostalgic remnant',
                          style: TextStyle(backgroundColor: Color(0x26C8873A)),
                        ),
                        TextSpan(
                          text:
                              ' of wartime necessity, rooftop gardens and community plots are now celebrated as forward-thinking solutions to food security, mental health, and environmental sustainability.\n\nProponents argue that urban farming reduces the ',
                        ),
                        TextSpan(
                          text: 'carbon footprint',
                          style: TextStyle(backgroundColor: Color(0x26C8873A)),
                        ),
                        TextSpan(
                          text:
                              ' associated with transporting produce from rural areas to city consumers. A tomato grown on a rooftop in Manhattan, for instance, travels metres rather than thousands of kilometres before reaching a plate. Critics, however, point out that the energy demands of indoor vertical farms — particularly the artificial lighting required — can actually exceed the emissions savings from shorter supply chains.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Text(
              'Questions 1–2'.toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
                color: IeltsColors.inkSoft,
              ),
            ),
          ),
          _QuestionCard(
            questionId: 'q1',
            number: 'Question 1',
            text:
                'According to the passage, urban farming was once considered to be',
            options: const [
              'an innovative environmental solution',
              'an outdated practice from the past',
              'a commercially unviable venture',
              'a government-sponsored initiative',
            ],
            selectedIndex: _selected['q1'],
            correctIndex: _correct['q1'],
            showResults: _showResults,
            onSelect: (value) {
              setState(() {
                _selected['q1'] = value;
              });
            },
          ),
          _QuestionCard(
            questionId: 'q2',
            number: 'Question 2',
            text: 'What concern do critics raise about vertical farms?',
            options: const [
              'They require too much water to operate',
              'Their energy use may cancel out emission benefits',
              'They cannot produce enough food for cities',
              'Consumers do not trust urban produce',
            ],
            selectedIndex: _selected['q2'],
            correctIndex: _correct['q2'],
            showResults: _showResults,
            onSelect: (value) {
              setState(() {
                _selected['q2'] = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showResults
                    ? null
                    : () {
                        setState(() {
                          _showResults = true;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IeltsColors.ink,
                  foregroundColor: IeltsColors.bg,
                  disabledBackgroundColor: IeltsColors.ink.withOpacity(0.4),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  _showResults ? '✓ Answers Revealed' : 'Check Answers',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String badge;

  const _PageHeader({
    required this.tag,
    required this.title,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: IeltsColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tag,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: IeltsColors.inkSoft,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: GoogleFonts.fraunces(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: IeltsColors.border),
            ),
            child: Text(
              badge,
              style: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: IeltsColors.inkSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final String questionId;
  final String number;
  final String text;
  final List<String> options;
  final int? selectedIndex;
  final int? correctIndex;
  final bool showResults;
  final ValueChanged<int> onSelect;

  const _QuestionCard({
    required this.questionId,
    required this.number,
    required this.text,
    required this.options,
    required this.selectedIndex,
    required this.correctIndex,
    required this.showResults,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: IeltsColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: IeltsColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: GoogleFonts.dmSans(
                fontSize: 11,
                color: IeltsColors.inkSoft,
              ),
            ),
            const SizedBox(height: 6),
            Text(text, style: GoogleFonts.dmSans(fontSize: 14, height: 1.55)),
            const SizedBox(height: 12),
            Column(
              children: List.generate(options.length, (index) {
                final bool isSelected = selectedIndex == index;
                final bool isCorrect = showResults && correctIndex == index;
                final bool isWrong = showResults && isSelected && !isCorrect;

                Color border = IeltsColors.border;
                Color background = Colors.transparent;
                Color textColor = IeltsColors.ink;

                if (isSelected && !showResults) {
                  border = IeltsColors.ink;
                  background = IeltsColors.ink;
                  textColor = IeltsColors.bg;
                } else if (isCorrect) {
                  border = IeltsColors.accent;
                  background = const Color(0x142D5016);
                  textColor = IeltsColors.accent;
                } else if (isWrong) {
                  border = IeltsColors.accentRed;
                  background = const Color(0x148B2D2D);
                  textColor = IeltsColors.accentRed;
                }

                return GestureDetector(
                  onTap: showResults ? null : () => onSelect(index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: border),
                      color: background,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: textColor, width: 1.5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            String.fromCharCode(65 + index),
                            style: GoogleFonts.dmSans(
                              fontSize: 9,
                              color: textColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            options[index],
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
