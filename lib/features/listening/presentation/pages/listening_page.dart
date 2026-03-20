import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts_cat/core/theme/ielts_colors.dart';

class ListeningPage extends StatefulWidget {
  const ListeningPage({super.key});

  @override
  State<ListeningPage> createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {
  double _progress = 0.35;
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(
            tag: 'Section 2 · Monologue',
            title: 'Listening',
            badge: '15 min',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: IeltsColors.ink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'City Library Tour',
                    style: GoogleFonts.fraunces(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: IeltsColors.bg,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Track 2 of 4 · 4:32',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: const Color(0x80F7F4EF),
                    ),
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        onTapDown: (details) {
                          final dx = details.localPosition.dx.clamp(
                            0.0,
                            constraints.maxWidth,
                          );
                          setState(() {
                            _progress = dx / constraints.maxWidth;
                          });
                        },
                        child: Container(
                          height: 3,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0x26FFFFFF),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: _progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: IeltsColors.accentWarm,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    margin: const EdgeInsets.only(right: -5),
                                    decoration: const BoxDecoration(
                                      color: IeltsColors.accentWarm,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1:35',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          color: const Color(0x66F7F4EF),
                        ),
                      ),
                      Text(
                        '4:32',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          color: const Color(0x66F7F4EF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CircleButton(icon: Icons.fast_rewind, onTap: () {}),
                      _CircleButton(
                        icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 48,
                        fillColor: IeltsColors.accentWarm,
                        iconColor: IeltsColors.bg,
                        onTap: () {
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        },
                      ),
                      _CircleButton(icon: Icons.fast_forward, onTap: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Text(
              'Questions 11–12'.toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
                color: IeltsColors.inkSoft,
              ),
            ),
          ),
          _StaticQuestionCard(
            number: 'Question 11',
            text: "The library's new reading room is located on the",
            options: const [
              'ground floor',
              'first floor',
              'second floor',
              'basement level',
            ],
          ),
          _StaticQuestionCard(
            number: 'Question 12',
            text: 'Membership cards can be obtained from the',
            options: const [
              'main entrance desk',
              'online portal only',
              'information centre',
              'third floor office',
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: IeltsColors.ink,
                  foregroundColor: IeltsColors.bg,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Submit Answers',
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

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color? fillColor;
  final Color? iconColor;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.size = 36,
    this.fillColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color background = fillColor ?? const Color(0x1AFFFFFF);
    final Color foreground = iconColor ?? IeltsColors.bg;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, color: foreground, size: 18),
      ),
    );
  }
}

class _StaticQuestionCard extends StatelessWidget {
  final String number;
  final String text;
  final List<String> options;

  const _StaticQuestionCard({
    required this.number,
    required this.text,
    required this.options,
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
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: IeltsColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: IeltsColors.ink,
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          String.fromCharCode(65 + index),
                          style: GoogleFonts.dmSans(fontSize: 9),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          options[index],
                          style: GoogleFonts.dmSans(fontSize: 13),
                        ),
                      ),
                    ],
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
