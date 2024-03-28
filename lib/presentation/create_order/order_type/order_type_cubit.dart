import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/presentation/create_order/order_type/order_type_state.dart';

class OrderTypeCubit extends Cubit<OrderTypeState> {
  OrderTypeCubit() : super(OrderTypeInitial());
  TextEditingController controller = TextEditingController();
  String selected = '';
}
