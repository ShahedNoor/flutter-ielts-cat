import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts_cat/core/theme/ielts_colors.dart';

class MyBottomAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomAppBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = const [
      _BottomBarItem(label: 'Home', icon: Icons.home),
      _BottomBarItem(label: 'Speaking', icon: Icons.mic),
      _BottomBarItem(label: 'Reading', icon: Icons.menu_book),
      _BottomBarItem(label: 'Listening', icon: Icons.headphones),
      _BottomBarItem(label: 'Writing', icon: Icons.edit),
    ];

    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: IeltsColors.surface,
        border: const Border(top: BorderSide(color: IeltsColors.border)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 24,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final bool isActive = index == currentIndex;

            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: isActive
                              ? IeltsColors.ink
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          item.icon,
                          size: 16,
                          color: isActive
                              ? IeltsColors.bg
                              : IeltsColors.inkSoft,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
                          color: isActive
                              ? IeltsColors.ink
                              : IeltsColors.inkSoft,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _BottomBarItem {
  final String label;
  final IconData icon;

  const _BottomBarItem({required this.label, required this.icon});
}
