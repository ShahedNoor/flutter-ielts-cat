import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAppStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String email;
  final String password;

  const AuthLoggedIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignedUp extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const AuthSignedUp({
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  List<Object> get props => [email, password, username];
}

class AuthLoggedOut extends AuthEvent {}
