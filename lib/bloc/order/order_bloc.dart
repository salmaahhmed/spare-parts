import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/data/repository/supplier/orders_repository.dart';

import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrdersEvent, OrderState> {
  final OrdersRepository orderRepository;

  OrderBloc(this.orderRepository);
  @override
  get initialState => GetOrdersLoading();

  @override
  Stream<OrderState> mapEventToState(OrdersEvent event) async* {
    if (event is GetOrders) {
      yield GetOrdersLoading();
      try {
        List<ParseObject> parseObjects = await orderRepository.getOrders();
        if (parseObjects.isNotEmpty) {
          yield GetOrderSuccess(parseObjects);
        } else {
          yield GetOrderEmpty("no Orders available");
        }
      } catch (e) {
        yield GetOrderFail(e.toString());
      }
    }
  }
}
