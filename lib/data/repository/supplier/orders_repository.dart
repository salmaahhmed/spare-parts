import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class OrdersRepository {
  Future<List<ParseObject>> getOrders();
  Future<ParseObject> acceptOrders(ParseObject acceptedOrder);
}
