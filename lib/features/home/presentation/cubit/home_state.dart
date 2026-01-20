part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int tabIndex;

  const HomeState(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
