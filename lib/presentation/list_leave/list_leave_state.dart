import 'package:equatable/equatable.dart';

class ListLeaveState extends Equatable {
  const ListLeaveState();

  @override
  List<Object> get props => [];
}

class ListLeaveInitial extends ListLeaveState {}

class ListLeaveLoading extends ListLeaveState {}

class ListLeaveFailure extends ListLeaveState {
  final String messageError;

  const ListLeaveFailure({required this.messageError});
}

class ListLeaveSuccess extends ListLeaveState {}
