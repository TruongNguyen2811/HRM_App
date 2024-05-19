import 'package:equatable/equatable.dart';

class ChangePassState extends Equatable {
  const ChangePassState();

  @override
  List<Object> get props => [];
}

class ChangePassInitial extends ChangePassState {}

class ChangePassLoading extends ChangePassState {}

class ChangePassFailure extends ChangePassState {
  final String messageError;

  const ChangePassFailure({required this.messageError});
}

class ChangePassSuccess extends ChangePassState {}
