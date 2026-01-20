import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ielts_cat/components/individual_score_calculator_card.dart';

part 'calculator_state.dart';

@injectable
class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  void calculateIndividual(ScoreType type, String rawInput) {
    final int? rawScore = int.tryParse(rawInput);

    if (rawScore == null || rawScore < 0 || rawScore > 40) {
      emit(const CalculatorError("Invalid input"));
      return;
    }

    double band;
    switch (type) {
      case ScoreType.listening:
        band = _getListeningBand(rawScore);
        break;
      case ScoreType.generalReading:
        band = _getGeneralReadingBand(rawScore);
        break;
      case ScoreType.academicReading:
        band = _getAcademicReadingBand(rawScore);
        break;
    }
    emit(CalculatorResult(band.toStringAsFixed(1)));
  }

  void calculateOverall(List<double> scores) {
    if (scores.any((score) => score == -1)) {
      emit(const CalculatorError('Please select a score for all sections'));
      return;
    }

    final average = scores.reduce((a, b) => a + b) / 4;
    double rounded;
    final decimal = average - average.floor();
    if (decimal < 0.25) {
      rounded = average.floorToDouble();
    } else if (decimal < 0.75) {
      rounded = average.floorToDouble() + 0.5;
    } else {
      rounded = average.ceilToDouble();
    }
    emit(CalculatorResult('Overall Band Score: ${rounded.toStringAsFixed(1)}'));
  }

  void reset() {
    emit(CalculatorInitial());
  }

  // Logic extracted from widgets
  double _getListeningBand(int score) {
    if (score >= 39) return 9.0;
    if (score >= 37) return 8.5;
    if (score >= 35) return 8.0;
    if (score >= 32) return 7.5;
    if (score >= 30) return 7.0;
    if (score >= 26) return 6.5;
    if (score >= 23) return 6.0;
    if (score >= 18) return 5.5;
    if (score >= 16) return 5.0;
    if (score >= 13) return 4.5;
    if (score >= 10) return 4.0;
    if (score >= 7) return 3.5;
    if (score >= 4) return 3.0;
    if (score >= 3) return 2.5;
    if (score >= 2) return 2.0;
    if (score >= 1) return 1.0;
    return 0.0;
  }

  double _getGeneralReadingBand(int score) {
    if (score >= 40) return 9.0;
    if (score >= 39) return 8.5;
    if (score >= 37) return 8.0;
    if (score >= 36) return 7.5;
    if (score >= 34) return 7.0;
    if (score >= 32) return 6.5;
    if (score >= 30) return 6.0;
    if (score >= 27) return 5.5;
    if (score >= 23) return 5.0;
    if (score >= 19) return 4.5;
    if (score >= 15) return 4.0;
    if (score >= 12) return 3.5;
    if (score >= 7) return 3.0;
    if (score >= 5) return 2.5;
    if (score >= 2) return 2.0;
    if (score >= 1) return 1.0;
    return 0.0;
  }

  double _getAcademicReadingBand(int score) {
    if (score >= 39) return 9.0;
    if (score >= 37) return 8.5;
    if (score >= 35) return 8.0;
    if (score >= 33) return 7.5;
    if (score >= 30) return 7.0;
    if (score >= 27) return 6.5;
    if (score >= 23) return 6.0;
    if (score >= 19) return 5.5;
    if (score >= 15) return 5.0;
    if (score >= 13) return 4.5;
    if (score >= 10) return 4.0;
    if (score >= 7) return 3.5;
    if (score >= 4) return 3.0;
    if (score >= 3) return 2.5;
    if (score >= 2) return 2.0;
    if (score >= 1) return 1.0;
    return 0.0;
  }
}
