import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparepart/bloc/order/order_bloc.dart';
import 'package:sparepart/bloc/order/order_event.dart';
import 'package:sparepart/bloc/order/order_state.dart';
import 'package:sparepart/page/home_page.dart';
import 'package:sparepart/widget/order_product_card.dart';
import 'package:sparepart/widget/orders_icon_widget.dart';

class OrderPage extends StatelessWidget {
  final OrderBloc orderBloc;

  const OrderPage({Key key, this.orderBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.more_vert)),
        ],
      ),
      body: BlocBuilder<OrdersEvent, OrderState>(
        bloc: orderBloc..dispatch(GetOrders()),
        builder: (context, OrderState state) {
          if (state is GetOrderSuccess) {
            return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(         
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: OrderProductCard(
                            order: state.orders[index], bloc: orderBloc)),
                  );
                });
          } else if (state is GetOrderFail) {
            return Center(
              child: Container(
                child: Text(state.error),
              ),
            );
          } else if (state is GetOrdersLoading) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is GetOrderEmpty) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text("You don't have any orders")),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    color: Colors.orange.shade500.withOpacity(0.8),
                    child: Text("Add new products?"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
