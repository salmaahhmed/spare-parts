import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/category_products/category_products_bloc.dart';
import 'package:sparepart/bloc/category_products/category_products_event.dart';
import 'package:sparepart/bloc/category_products/category_products_state.dart';

class ProductCard extends StatefulWidget {
  final ParseObject product;
  final CategoryProductBloc bloc;
  const ProductCard({Key key, this.product, this.bloc}) : super(key: key);

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
      child: Column(
        children: <Widget>[
          Container(
            child: widget.product == null
                ? Container()
                : Image.network(widget.product.get("product_image")),
            width: 70,
            height: 80,
            color: Colors.grey.shade300,
          ),
          Text("product"),
          Text("product description"),
          Container(
              height: 15,
              width: 60,
              child: RaisedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return BlocBuilder<CategoryProductsEvent,
                            CategoryProductState>(
                          bloc: widget.bloc,
                          builder: (BuildContext context,
                              CategoryProductState state) {
                            if (state is AddProductSuccess) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                            if (state is AddProductFail) {
                              return Container(
                                  child: Center(
                                child: Text("adding product failed"),
                              ));
                            }
                            return AlertDialog(
                              content: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    state is AddProductLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Container(),
                                    Center(
                                      child: Text("Add product price"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        onSaved: (value) =>
                                            _productPrice = double.parse(value),
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
                },
                child: Text("add product ?"),
              ))
        ],
      ),
    );
  }
}
