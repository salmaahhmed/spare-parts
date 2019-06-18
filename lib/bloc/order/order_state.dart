import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class OrderState extends Equatable {}

class GetOrdersLoading extends OrderState {
  @override
  String toString() => 'GetOrdersLoading';
}


class GetOrderSuccess extends OrderState {
  final List<ParseObject> orders;

  GetOrderSuccess(this.orders);

  @override
  String toString() => 'getOrdersSuccess { size: ${orders.length} }';
}
class AcceptOrderSuccess extends OrderState {
  final ParseObject acceptedOrder;

  AcceptOrderSuccess(this.acceptedOrder);


  @override
  String toString() => 'accept order Success';
}

class GetOrderFail extends OrderState {
  final String error;

  GetOrderFail(this.error);

  @override
  String toString() => 'getOrdersFail { error: $error }';
}

class GetOrderEmpty extends OrderState {
  final String error;

  GetOrderEmpty(this.error);

  @override
  String toString() => 'getOrdersEmpty {"error: $error"}';
}
