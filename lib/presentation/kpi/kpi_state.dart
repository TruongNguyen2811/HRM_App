import 'package:equatable/equatable.dart';

class KPIState extends Equatable {
  const KPIState();

  @override
  List<Object> get props => [];
}

class KPIInitial extends KPIState {}

class KPILoading extends KPIState {}

class KPIFailure extends KPIState {
  final String messageError;

  const KPIFailure({required this.messageError});
}

class KPIGetDataSuccess extends KPIState {}

class GetEmployeeSuccess extends KPIState {}
