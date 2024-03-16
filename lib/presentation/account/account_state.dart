import 'package:equatable/equatable.dart';

class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountFailure extends AccountState {
  final String messageError;

  const AccountFailure({required this.messageError});
}

class AccountGetDataSuccess extends AccountState {}

class AccountLogOutSuccess extends AccountState {}
