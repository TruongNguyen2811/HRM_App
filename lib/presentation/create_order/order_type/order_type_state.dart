import 'package:equatable/equatable.dart';

abstract class OrderTypeState {
  const OrderTypeState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class OrderTypeInitial extends OrderTypeState {}

class OrderTypeLoading extends OrderTypeState {}

class SubmitTypeFailure extends OrderTypeState {
  final String error;
  const SubmitTypeFailure(this.error);
}

class SubmitTypeSucess extends OrderTypeState {
  SubmitTypeSucess();
}
