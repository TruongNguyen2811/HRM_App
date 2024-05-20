import 'package:equatable/equatable.dart';

class ContractState extends Equatable {
  const ContractState();

  @override
  List<Object> get props => [];
}

class ContractInitial extends ContractState {}

class ContractLoading extends ContractState {}

class ContractFailure extends ContractState {
  final String messageError;

  const ContractFailure({required this.messageError});
}

class ContractGetDataSuccess extends ContractState {}
