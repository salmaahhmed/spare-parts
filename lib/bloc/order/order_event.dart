import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  OrdersEvent([List props = const []]) : super(props);
}

class GetOrders extends OrdersEvent {
  GetOrders();

  @override
  String toString() => 'getOrders {}}';
}