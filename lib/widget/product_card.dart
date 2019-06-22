import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/category_products/category_products_bloc.dart';
import 'package:sparepart/bloc/category_products/category_products_event.dart';
import 'package:sparepart/bloc/category_products/category_products_state.dart';

class ProductCard extends StatefulWidget {
  final ParseObject product;
  final CategoryProductBloc bloc;
  final bool added;
  const ProductCard({Key key, this.product, this.bloc, this.added}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductCardState();
  }
}

class _ProductCardState extends State<ProductCard> {
  final _formKey = GlobalKey<FormState>();
  double _productPrice;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.added == true ? Colors.transparent: Colors.grey.shade100,
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
                  onPressed: () async {
                    var res = await showDialog<bool>(
                        context: context,
                        builder: (ctx) {
                          return BlocBuilder<CategoryProductsEvent,
                              CategoryProductState>(
                            bloc: widget.bloc,
                            builder: (BuildContext context,
                                CategoryProductState state) {
                              if (state is AddProductSuccess) {
                                Navigator.of(ctx).pop(true);
                              }
                              if (state is AddProductFail) {
                                Navigator.of(ctx).pop(true);
                              }
                              return AlertDialog(
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      state is AddProductLoading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : Container(),
                                      Center(
                                        child: Text("Add product price"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          onSaved: (value) => _productPrice =
                                              double.parse(value),
                                          validator: (value) {
                                            if (value.length == 0) {
                                              return "price cant be empty";
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          color: Colors.orange.withOpacity(0.8),
                                          child: Text("Add product"),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();
                                              widget.bloc.dispatch(
                                                  AddProductToCategory(
                                                      widget.product,
                                                      _productPrice));
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        });
                    print(res);
                  },
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
