import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts_cat/core/theme/ielts_colors.dart';
import 'package:ielts_cat/core/widgets/my_bottom_app_bar.dart';
import 'package:ielts_cat/features/listening/presentation/pages/listening_page.dart';
import 'package:ielts_cat/features/reading/presentation/pages/reading_page.dart';
import 'package:ielts_cat/features/speaking/presentation/pages/speaking_page.dart';
import 'package:ielts_cat/features/writing/presentation/pages/writing_page.dart';
import 'package:ielts_cat/features/home/presentation/cubit/home_cubit.dart';
import 'package:ielts_cat/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: Scaffold(
        backgroundColor: IeltsColors.bg,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final pages = <Widget>[
              _HomeOverview(
                onPlanTap: (index) {
                  context.read<HomeCubit>().changeTab(index);
                },
              ),
              const SpeakingPage(),
              const ReadingPage(),
              const ListeningPage(),
              const WritingPage(),
            ];

            return pages[state.tabIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return MyBottomAppBar(
              currentIndex: state.tabIndex,
              onTap: (index) => context.read<HomeCubit>().changeTab(index),
            );
          },
        ),
      ),
    );
  }
}

class _HomeOverview extends StatelessWidget {
  final void Function(int) onPlanTap;

  const _HomeOverview({required this.onPlanTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
            decoration: const BoxDecoration(color: IeltsColors.ink),
            child: Stack(
              children: [
                Positioned(
                  right: -10,
                  top: 8,
                  child: Text(
                    'IELTS',
                    style: GoogleFonts.fraunces(
                      fontSize: 110,
                      fontWeight: FontWeight.w600,
                      color: const Color(0x0AFFFFFF),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                        color: const Color(0x80F7F4EF),
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Ready to ',
                            style: GoogleFonts.fraunces(
                              fontSize: 36,
                              fontWeight: FontWeight.w300,
                              height: 1.15,
                              color: IeltsColors.bg,
                            ),
                          ),
                          TextSpan(
                            text: 'ace',
                            style: GoogleFonts.fraunces(
                              fontSize: 36,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              height: 1.15,
                              color: IeltsColors.accentWarm,
                            ),
                          ),
                          TextSpan(
                            text: '\n',
                            style: GoogleFonts.fraunces(
                              fontSize: 36,
                              fontWeight: FontWeight.w300,
                              height: 1.15,
                              color: IeltsColors.bg,
                            ),
                          ),
                          TextSpan(
                            text: 'your IELTS?',
                            style: GoogleFonts.fraunces(
                              fontSize: 36,
                              fontWeight: FontWeight.w300,
                              height: 1.15,
                              color: IeltsColors.bg,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        _ScorePill(
                          label: 'Band',
                          value: '6.5',
                          suffix: 'Current',
                        ),
                        const SizedBox(width: 12),
                        _ScorePill(label: 'Target', value: '7.5'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          _Section(
            title: "Today's Plan",
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
                children: [
                  _PlanCard(
                    dotColor: IeltsColors.accentWarm,
                    label: 'Speaking',
                    title: 'Part 2 Cue Card',
                    meta: '2 min',
                    onTap: () => onPlanTap(1),
                  ),
                  _PlanCard(
                    dotColor: IeltsColors.accent,
                    label: 'Reading',
                    title: 'Passage + MCQs',
                    meta: '20 min',
                    onTap: () => onPlanTap(2),
                  ),
                  _PlanCard(
                    dotColor: IeltsColors.accentBlue,
                    label: 'Listening',
                    title: 'Section 2 Audio',
                    meta: '15 min',
                    onTap: () => onPlanTap(3),
                  ),
                  _PlanCard(
                    dotColor: IeltsColors.accentRed,
                    label: 'Writing',
                    title: 'Task 2 Essay',
                    meta: '40 min',
                    onTap: () => onPlanTap(4),
                  ),
                ],
              ),
            ),
          ),
          _Section(
            title: 'Weekly Progress',
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: IeltsColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: IeltsColors.border),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          value: 0.69,
                          strokeWidth: 4,
                          backgroundColor: IeltsColors.border,
                          color: IeltsColors.accent,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '69%',
                            style: GoogleFonts.fraunces(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Weekly goal',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: IeltsColors.inkSoft,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '5 of 7 days',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'practice streak',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: IeltsColors.inkSoft,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: const [
                    _WeekBar(label: 'M', fill: 1.0),
                    _WeekBar(label: 'T', fill: 0.8),
                    _WeekBar(label: 'W', fill: 1.0),
                    _WeekBar(label: 'T', fill: 0.6),
                    _WeekBar(label: 'F', fill: 0.4, isToday: true),
                    _WeekBar(label: 'S', fill: 0.0),
                    _WeekBar(label: 'S', fill: 0.0),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ScorePill extends StatelessWidget {
  final String label;
  final String value;
  final String? suffix;

  const _ScorePill({required this.label, required this.value, this.suffix});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(fontSize: 13, color: IeltsColors.bg),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: IeltsColors.accentWarm,
            ),
          ),
          if (suffix != null) ...[
            const SizedBox(width: 6),
            Text(
              suffix!,
              style: GoogleFonts.dmSans(fontSize: 13, color: IeltsColors.bg),
            ),
          ],
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
              color: IeltsColors.inkSoft,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final Color dotColor;
  final String label;
  final String title;
  final String meta;
  final VoidCallback onTap;

  const _PlanCard({
    required this.dotColor,
    required this.label,
    required this.title,
    required this.meta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: IeltsColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: IeltsColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 11,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
                color: IeltsColors.inkSoft,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.fraunces(
                fontSize: 17,
                fontWeight: FontWeight.w300,
                height: 1.3,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  size: 12,
                  color: IeltsColors.inkSoft,
                ),
                const SizedBox(width: 4),
                Text(
                  meta,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: IeltsColors.inkSoft,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekBar extends StatelessWidget {
  final String label;
  final double fill;
  final bool isToday;

  const _WeekBar({
    required this.label,
    required this.fill,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 36,
            margin: const EdgeInsets.symmetric(horizontal: 2.5),
            decoration: BoxDecoration(
              color: IeltsColors.border,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: fill,
                child: Container(
                  decoration: BoxDecoration(
                    color: isToday ? IeltsColors.accentWarm : IeltsColors.ink,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 10,
              letterSpacing: 0.5,
              color: IeltsColors.inkSoft,
            ),
          ),
        ],
      ),
    );
  }
}
