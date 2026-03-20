import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts_cat/core/theme/ielts_colors.dart';

class SpeakingPage extends StatefulWidget {
  const SpeakingPage({super.key});

  @override
  State<SpeakingPage> createState() => _SpeakingPageState();
}

class _SpeakingPageState extends State<SpeakingPage>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _seconds = 0;
  bool _recording = false;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      _recording = !_recording;
    });

    if (_recording) {
      _pulseController.repeat(reverse: true);
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          _seconds += 1;
        });
      });
    } else {
      _pulseController.stop();
      _pulseController.reset();
      _timer?.cancel();
    }
  }

  String get _timerText {
    final minutes = _seconds ~/ 60;
    final seconds = _seconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 52, 24, 36),
            color: IeltsColors.ink,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: IeltsColors.accentWarm),
                    color: IeltsColors.accentWarm.withOpacity(0.2),
                  ),
                  child: Text(
                    'Part 2 · Cue Card'.toUpperCase(),
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: IeltsColors.accentWarm,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Describe a place you would like to visit',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fraunces(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                    color: IeltsColors.bg,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Prepare 1 min · Speak 2 min',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: const Color(0x80F7F4EF),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: IeltsColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: IeltsColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You should say'.toUpperCase(),
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      letterSpacing: 1.5,
                      color: IeltsColors.inkSoft,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '• Where this place is located\n• How you know about this place\n• What you would do there\n• And explain why you would like to visit this place',
                    style: GoogleFonts.dmSans(fontSize: 14, height: 1.55),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
            child: Column(
              children: [
                Text(
                  _timerText,
                  style: GoogleFonts.fraunces(
                    fontSize: 36,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _recording
                      ? 'Recording… tap to stop'
                      : 'Tap to start recording',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    letterSpacing: 1,
                    color: IeltsColors.inkSoft,
                  ),
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_recording)
                      ScaleTransition(
                        scale: Tween<double>(begin: 1, end: 1.25).animate(
                          CurvedAnimation(
                            parent: _pulseController,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: IeltsColors.accentRed.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: _toggleRecording,
                      borderRadius: BorderRadius.circular(44),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: _recording
                              ? IeltsColors.accentRed
                              : IeltsColors.ink,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 32,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Speak clearly and at a natural pace. You will be scored on fluency, vocabulary, grammar and pronunciation.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    height: 1.6,
                    color: IeltsColors.inkSoft,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Band Descriptors'.toUpperCase(),
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: IeltsColors.inkSoft,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.4,
                  children: const [
                    _DescriptorCard(
                      label: 'Fluency',
                      text: 'Speak without long pauses or repetition',
                    ),
                    _DescriptorCard(
                      label: 'Vocabulary',
                      text: 'Use less common and idiomatic words',
                    ),
                    _DescriptorCard(
                      label: 'Grammar',
                      text: 'Mix simple and complex structures',
                    ),
                    _DescriptorCard(
                      label: 'Pronunciation',
                      text: 'Clear sound and natural intonation',
                    ),
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

class _DescriptorCard extends StatelessWidget {
  final String label;
  final String text;

  const _DescriptorCard({required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: IeltsColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: IeltsColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.dmSans(
              fontSize: 11,
              letterSpacing: 1.5,
              color: IeltsColors.inkSoft,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              height: 1.5,
              color: IeltsColors.inkSoft,
            ),
          ),
        ],
      ),
    );
  }
}
