import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ProductCard extends StatelessWidget {
  final ParseObject product;

  const ProductCard({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            child: product == null
                ? Container()
                : Image.network(product.get("product_image")),
            width: 70,
            height: 80,
            color: Colors.grey.shade300,
          ),
          Text("product"),
          Text("product description"),
          Container(height: 15, width: 60, child: RaisedButton(onPressed: (){},child: Text("add product ?"),))
        ],
      ),
    );
  }
}
