import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/data/remote_provider/order_api_provider.dart';

import 'orders_repository.dart';

class OrdersRepositoryImplementation extends OrdersRepository{

  final OrderApiProvider orderApiProvider;
  OrdersRepositoryImplementation(this.orderApiProvider);
  @override
  Future<List<ParseObject>> getOrders() async{
    return orderApiProvider.getOrders(await ParseUser.currentUser());
  }
}