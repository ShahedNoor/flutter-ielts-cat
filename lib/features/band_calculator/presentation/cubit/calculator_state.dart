part of 'calculator_cubit.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorResult extends CalculatorState {
  final String result;

  const CalculatorResult(this.result);

  @override
  List<Object> get props => [result];
}

class CalculatorError extends CalculatorState {
  final String message;

  const CalculatorError(this.message);

  @override
  List<Object> get props => [message];
}
