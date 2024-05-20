import 'package:equatable/equatable.dart';

class CreateEquipmentState extends Equatable {
  const CreateEquipmentState();

  @override
  List<Object> get props => [];
}

class CreateEquipmentInitial extends CreateEquipmentState {}

class CreateEquipmentLoading extends CreateEquipmentState {}

class CreateEquipmentFailure extends CreateEquipmentState {
  final String messageError;

  const CreateEquipmentFailure({required this.messageError});
}

class CreateEquipmentSuccess extends CreateEquipmentState {}

class CreateEquipmentEquipmentSuccess extends CreateEquipmentState {}

class CreateEquipmentGetEmployeeSuccess extends CreateEquipmentState {}

class CreateEquipmentChooseEmployeeSuccess extends CreateEquipmentState {}

class CreateEquipmentChooseEquipmentSuccess extends CreateEquipmentState {}

class CreateEquipmentChooseTime extends CreateEquipmentState {}
