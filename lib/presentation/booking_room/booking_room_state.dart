import 'package:equatable/equatable.dart';

class BookingRoomState extends Equatable {
  const BookingRoomState();

  @override
  List<Object> get props => [];
}

class BookingRoomInitial extends BookingRoomState {}

class BookingRoomLoading extends BookingRoomState {}

class BookingRoomFailure extends BookingRoomState {
  final String messageError;

  const BookingRoomFailure({required this.messageError});
}

class BookingRoomSuccess extends BookingRoomState {}

class BookingRoomGetRoomSuccess extends BookingRoomState {}

class BookingRoomGetEmployeeSuccess extends BookingRoomState {}

class BookingRoomChooseEmployeeSuccess extends BookingRoomState {}

class BookingRoomChooseRoomSuccess extends BookingRoomState {}

class BookingRoomChooseTime extends BookingRoomState {}
