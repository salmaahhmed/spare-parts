import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/order/order_bloc.dart';
import 'package:sparepart/bloc/order/order_event.dart';

class OrderProductCard extends StatelessWidget {
  final ParseObject order;
  final OrderBloc bloc;
  const OrderProductCard({Key key, this.order, this.bloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ParseObject object = order?.get("supplier_spare_part_id");
    ParseObject orderss = object?.get("spare_part_id");
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Product Name: ',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.button,
                    ),
                    Text("${orderss?.get<String>("name") ?? "Orange"}"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Quantity: ",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.button,
                    ),
                    Text("${order?.get<String>(
                          "quantity",
                        ) ?? "quantity"}")
                  ],
                ),
                Row(children: <Widget>[
                  Text(
                    "Price: ",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.button,
                  ),
                  Text("${object?.get("price") ?? "100"}"),
                  Text("LE"),
                ])
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: 50,
              child: FlatButton(
                onPressed: () {
                  bloc..dispatch(AcceptOrder(order));
                },
                color: Colors.green,
                child: Container(
                  child: Text(
                    "Accept",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
