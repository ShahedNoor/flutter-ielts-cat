import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/theme/dark_mode.dart';
import '../../../../config/theme/light_mode.dart';

@injectable
class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightMode);

  void toggleTheme() {
    emit(state.brightness == Brightness.light ? darkMode : lightMode);
  }
}
