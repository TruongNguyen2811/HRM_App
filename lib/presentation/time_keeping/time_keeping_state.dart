import 'package:equatable/equatable.dart';

class TimeKeepingState extends Equatable {
  const TimeKeepingState();

  @override
  List<Object> get props => [];
}

class TimeKeepingInitial extends TimeKeepingState {}

class TimeKeepingLoading extends TimeKeepingState {}

class TimeKeepingFailure extends TimeKeepingState {
  final String messageError;

  const TimeKeepingFailure({required this.messageError});
}

class TimeKeepingGetDataSuccess extends TimeKeepingState {}
