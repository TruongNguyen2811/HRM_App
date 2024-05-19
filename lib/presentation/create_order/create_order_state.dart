import 'package:equatable/equatable.dart';

class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderFailure extends CreateOrderState {
  final String messageError;

  const CreateOrderFailure({required this.messageError});
}

class CreateOrderSuccess extends CreateOrderState {}

class GetListQuotesSuccess extends CreateOrderState {}

class GetEmployeeSuccess extends CreateOrderState {}
