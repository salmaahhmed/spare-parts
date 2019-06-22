import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparepart/bloc/order/order_bloc.dart';
import 'package:sparepart/bloc/order/order_event.dart';
import 'package:sparepart/bloc/order/order_state.dart';
import 'package:sparepart/widget/order_product_card.dart';
import 'package:sparepart/widget/orders_icon_widget.dart';

class OrderPage extends StatelessWidget {
  final OrderBloc orderBloc;

  const OrderPage( {Key key, this.orderBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersEvent, OrderState>(
      bloc: orderBloc,
      builder: (context, OrderState state) {
        if (state is GetOrderSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Categories"),
              leading: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                      onTap: () {
                        OrderPage();
                      },
                      child: OrderIcon())),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.more_vert)),
              ],
            ),
            body: ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (ctx, index) {
                return Padding(
                    padding: EdgeInsets.all(10), child: OrderProductCard());
              },
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Categories"),
            leading: Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => OrderPage()));
                    },
                    child: OrderIcon())),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.more_vert)),
            ],
          ),
          body: ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, index) {
              return Padding(
                  padding: EdgeInsets.all(10), child: OrderProductCard());
            },
          ),
        );
      },
    );
  }
}
