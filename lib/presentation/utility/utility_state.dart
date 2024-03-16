import 'package:equatable/equatable.dart';

class UtilityState extends Equatable {
  const UtilityState();

  @override
  List<Object> get props => [];
}

class UtilityInitial extends UtilityState {}

class UtilityLoading extends UtilityState {}

class UtilityFailure extends UtilityState {
  final String messageError;

  const UtilityFailure({required this.messageError});
}

class UtilityGetDataSuccess extends UtilityState {}
