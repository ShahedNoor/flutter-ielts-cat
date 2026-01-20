import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_cat/components/my_app_bar.dart';
import 'package:ielts_cat/components/my_bottom_app_bar.dart';
import 'package:ielts_cat/components/my_drawer.dart';
import 'package:ielts_cat/features/calculator/presentation/pages/calculator_page.dart';
import 'package:ielts_cat/features/listening/presentation/pages/listening_page.dart';
import 'package:ielts_cat/features/reading/presentation/pages/reading_page.dart';
import 'package:ielts_cat/features/speaking/presentation/pages/speaking_page.dart';
import 'package:ielts_cat/features/writing/presentation/pages/writing_page.dart';
import 'package:ielts_cat/features/home/presentation/cubit/home_cubit.dart';
import 'package:ielts_cat/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // List of pages
  final List<Widget> pages = const [
    ListeningPage(),
    ReadingPage(),
    WritingPage(),
    SpeakingPage(),
    CalculatorPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(),
        drawer: const MyDrawer(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
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
