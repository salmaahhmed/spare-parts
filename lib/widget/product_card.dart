import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/category_products/category_products_bloc.dart';

class ProductCard extends StatefulWidget {
  final ParseObject product;
  final CategoryProductBloc bloc;
  final Function onPressed;
  final GlobalKey formKey;
  const ProductCard(
      {Key key,
      this.product,
      this.bloc,
      this.onPressed,
      this.formKey})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductCardState();
  }
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 400,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: widget.product == null
                    ? Container()
                    : Image.network(widget.product.get("product_image")),
                width: 70,
              ),
            ),
            Text(
              widget.product.get("name"),
              style: Theme.of(context).textTheme.button,
            ),
            SizedBox(height: 10),
            Container(
              height: 20,
              width: 130,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(0.5)),
                child: RaisedButton(
                  onPressed: widget.onPressed,
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.orange.withOpacity(0.8),
                ),
              ),
            ),
            SizedBox(height: 10),
            Icon(Icons.expand_more),
          ],
        ),
      ),
    );
  }
}

void _redirectToPage(BuildContext context, Widget page) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    MaterialPageRoute newRoute =
        MaterialPageRoute(builder: (BuildContext context) => page);

    Navigator.of(context).push(newRoute);
  });
}
