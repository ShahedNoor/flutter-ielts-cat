import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription? _authSubscription;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthAppStarted>(_onAppStarted);
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLoggedIn>(_onLoggedIn);
    on<AuthSignedUp>(_onSignedUp);
    on<AuthLoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(
    AuthAppStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // Cancel existing subscription if any
    await _authSubscription?.cancel();
    // Listen to repo stream
    _authSubscription = _authRepository.user.listen((user) {
      add(AuthUserChanged(user));
    });
  }

  Future<void> _onUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user != null) {
      emit(Authenticated(event.user!));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      // The stream will handle the state update to Authenticated
    } catch (e) {
      emit(AuthError(e.toString()));
      // If error, likely revert to Unauthenticated or stay in error state
      // For now, let's go back to Unauthenticated after error so user can retry?
      // Or just keep AuthError.
    }
  }

  Future<void> _onSignedUp(AuthSignedUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUpWithEmailAndPassword(
        event.email,
        event.password,
        event.username,
      );
      // Stream handles success
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _authRepository.signOut();
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}

class AuthUserChanged extends AuthEvent {
  final UserEntity? user;
  const AuthUserChanged(this.user);

  @override
  List<Object> get props => [user ?? 'null'];
}
