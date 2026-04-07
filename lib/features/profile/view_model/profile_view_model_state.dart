import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class ProfileViewModelState extends Equatable {
  const ProfileViewModelState();

  @override
  List<Object?> get props => [];
}

/// Initial / still loading state — skeleton shown while data fetches.
class ProfileInitial extends ProfileViewModelState {}

class ProfileLoaded extends ProfileViewModelState {
  final bool isProfileCompleted;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  /// Decoded logo bytes ready for `Image.memory`. Null when not yet loaded.
  final Uint8List? logoBytes;

  const ProfileLoaded({
    required this.isProfileCompleted,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.logoBytes,
  });

  @override
  List<Object?> get props => [
        isProfileCompleted,
        fullName,
        email,
        phoneNumber,
        logoBytes,
      ];
}

class ProfileError extends ProfileViewModelState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
