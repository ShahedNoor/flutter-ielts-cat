import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts_cat/core/theme/ielts_colors.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({super.key});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final TextEditingController _controller = TextEditingController();
  int _task = 2;
  int _wordCount = 0;

  String get _prompt {
    if (_task == 1) {
      return 'The bar chart below shows the percentage of households in different income groups that owned a computer in 2005 and 2015. Summarise the information by selecting and reporting the main features, and make comparisons where relevant.';
    }

    return 'Some people believe that technology has made our lives more complicated, while others argue that it has simplified everyday tasks. Discuss both views and give your own opinion.';
  }

  void _updateWordCount(String value) {
    final trimmed = value.trim();
    final count = trimmed.isEmpty ? 0 : trimmed.split(RegExp(r'\s+')).length;
    setState(() {
      _wordCount = count;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _updateWordCount(_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchTask(int task) {
    setState(() {
      _task = task;
      _controller.clear();
      _wordCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final percent = (_wordCount / 250).clamp(0.0, 1.0);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(
            tag: 'Academic Writing',
            title: 'Writing',
            badge: '60 min',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: _TaskTab(
                    label: 'Task 1',
                    isActive: _task == 1,
                    onTap: () => _switchTask(1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _TaskTab(
                    label: 'Task 2',
                    isActive: _task == 2,
                    onTap: () => _switchTask(2),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0x101B3A5C),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                border: const Border(
                  left: BorderSide(color: IeltsColors.accentBlue, width: 3),
                ),
              ),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.dmSans(
                    fontSize: 13.5,
                    height: 1.7,
                    color: IeltsColors.accentBlue,
                  ),
                  children: [
                    TextSpan(
                      text: _task == 1
                          ? 'Task 1 · Graph Description\n'
                          : 'Task 2 · Opinion Essay\n',
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        height: 1.8,
                        color: IeltsColors.accentBlue.withOpacity(0.7),
                      ),
                    ),
                    TextSpan(text: _prompt),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
            child: Row(
              children: const [
                Expanded(
                  child: _TipChip(value: '250+', label: 'min words'),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _TipChip(value: '40', label: 'minutes'),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _TipChip(value: '4', label: 'paragraphs'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_wordCount / 250 words',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: IeltsColors.inkSoft,
                  ),
                ),
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: IeltsColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: percent,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: IeltsColors.accent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            child: Container(
              decoration: BoxDecoration(
                color: IeltsColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: IeltsColors.border),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 10,
                style: GoogleFonts.dmSans(fontSize: 14, height: 1.7),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(18),
                  hintText:
                      'Begin your essay here. Start with a clear introduction that paraphrases the question and states your position…',
                  hintStyle: GoogleFonts.dmSans(color: IeltsColors.inkSoft),
                ),
              ),
            ),
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
                  'Submit Essay',
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

class _TaskTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TaskTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? IeltsColors.ink : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: IeltsColors.border),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isActive ? IeltsColors.bg : IeltsColors.inkSoft,
          ),
        ),
      ),
    );
  }
}

class _TipChip extends StatelessWidget {
  final String value;
  final String label;

  const _TipChip({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: IeltsColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: IeltsColors.border),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.fraunces(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: IeltsColors.ink,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.dmSans(fontSize: 11, color: IeltsColors.inkSoft),
          ),
        ],
      ),
    );
  }
}
