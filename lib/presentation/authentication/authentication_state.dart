import 'package:equatable/equatable.dart';

import '../../utils/enum.dart';

abstract class AppState extends Equatable {
  const AppState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AppState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AppState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AppState {
  final bool isSignUp;
  final String? errorMessage;
  const AuthenticationUnauthenticated(
      {this.isSignUp = false, this.errorMessage})
      : super();

  @override
  String toString() {
    return 'AuthenticationUnauthenticated';
  }

  @override
  List<Object> get props => [isSignUp, errorMessage ?? ""];
}

class AuthenticationUninitialized extends AppState {
  @override
  String toString() {
    return 'AuthenticationUninitialized';
  }
}

class AuthenticationLogin extends AppState {
  @override
  String toString() => 'AuthenticationLogin';
}

class AuthenticationSignUp extends AppState {
  @override
  String toString() => 'AuthenticationSignUp';
}

class AuthenticationLoading extends AppState {
  @override
  String toString() => 'AuthenticationLoading';
}

class MessageState extends AppState {
  final String message;
  final ToastType messageType;

  const MessageState(this.message, this.messageType);
}

class ErrorState extends AppState {
  final String error;

  const ErrorState({required this.error});

  @override
  String toString() {
    return 'ErrorState {error: $error}';
  }
}
