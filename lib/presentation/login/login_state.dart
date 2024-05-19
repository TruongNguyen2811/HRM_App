part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginPhoneNotUpdatePassword extends LoginState {}

class LoginFailure extends LoginState {
  final String messageError;

  const LoginFailure({required this.messageError});
}

class LoginSuccess extends LoginState {}

class GetBioSuccess extends LoginState {}
