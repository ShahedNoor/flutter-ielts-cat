import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String email;

  const LoadProfile(this.email);

  @override
  List<Object> get props => [email];
}
