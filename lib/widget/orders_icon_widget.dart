import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparepart/bloc/order/order_bloc.dart';
import 'package:sparepart/bloc/order/order_event.dart';
import 'package:sparepart/bloc/order/order_state.dart';

class OrderIcon extends StatelessWidget {
  final OrderBloc orderBloc;
  const OrderIcon({Key key, this.orderBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(10),
            child: Center(
                child: Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ))),
        Positioned(
          bottom: 30,
          left: 24,
          child: CircleAvatar(
            maxRadius: 10,
            backgroundColor: Colors.orange.withOpacity(0.8),
            child: Center(
              child: BlocBuilder<OrdersEvent, OrderState>(
                bloc: orderBloc..dispatch(GetOrders()),
                builder: (context, state) {
                  if (state is GetOrderSuccess) {
                    return Text(
                      state.orders.length.toString(),
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    return Text(
                      "0",
                      style: TextStyle(color: Colors.white),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
