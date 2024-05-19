import 'package:equatable/equatable.dart';

class ListEquipmentState extends Equatable {
  const ListEquipmentState();

  @override
  List<Object> get props => [];
}

class ListEquipmentInitial extends ListEquipmentState {}

class ListEquipmentLoading extends ListEquipmentState {}

class ListEquipmentFailure extends ListEquipmentState {
  final String messageError;

  const ListEquipmentFailure({required this.messageError});
}

class ListEquipmentSuccess extends ListEquipmentState {}
