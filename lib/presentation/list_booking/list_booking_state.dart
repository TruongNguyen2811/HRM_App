import 'package:equatable/equatable.dart';

class ListBookingState extends Equatable {
  const ListBookingState();

  @override
  List<Object> get props => [];
}

class ListBookingInitial extends ListBookingState {}

class ListBookingLoading extends ListBookingState {}

class ListBookingFailure extends ListBookingState {
  final String messageError;

  const ListBookingFailure({required this.messageError});
}

class ListBookingSuccess extends ListBookingState {}
