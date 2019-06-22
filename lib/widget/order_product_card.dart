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
      child: Row(
        children: <Widget>[
          //    FlutterLogo(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Product Name: ${orderss?.get<String>("name") ?? "Orange"}',
                textAlign: TextAlign.left,
              ),
              Text(
                'Product Desciption: ${orderss?.get("desciption") ?? "product for tesing some info about how to get most"}',
                textAlign: TextAlign.left,
              ),
              Text(
                "Quantity: ${order?.get<String>(
                  "quantity",
                )}?? quantity",
                textAlign: TextAlign.start,
              ),
              Text(
                "Price: ${object?.get("price")}?? 100\$",
                textAlign: TextAlign.start,
              )
            ],
          ),
          Container(
            child: FlatButton(
              onPressed: () {
                bloc..dispatch(AcceptOrder(order));
              },
              color: Colors.green,
              child: Text("Accept"),
            ),
          ),
        ],
      ),
    );
  }
}
