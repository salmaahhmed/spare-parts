import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class OrderProductCard extends StatelessWidget {
  final ParseObject order;

  const OrderProductCard({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: <Widget>[
          FlutterLogo(),
          Column(
            children: <Widget>[
              Text("product name"),
              Text("ordered by: customer name"),
            ],
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("accept order"),
          ),
        ],
      ),
    );
  }
}
