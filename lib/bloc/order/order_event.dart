import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class OrdersEvent extends Equatable {
  OrdersEvent([List props = const []]) : super(props);
}

class GetOrders extends OrdersEvent {
  @override
  String toString() => 'getOrders {}}';
}

class AcceptOrder extends OrdersEvent {
  final ParseObject acceptedOrder;

  AcceptOrder(this.acceptedOrder);
  @override
  String toString() => 'acceptOrder {}}';
}
