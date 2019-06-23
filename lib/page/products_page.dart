import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/category_products/category_products_bloc.dart';
import 'package:sparepart/bloc/category_products/category_products_event.dart';
import 'package:sparepart/bloc/category_products/category_products_state.dart';
import 'package:sparepart/widget/product_card.dart';

class ProductsPage extends StatelessWidget {
  final ParseObject category;
  final CategoryProductBloc bloc;
  const ProductsPage({Key key, this.category, this.bloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    double _price;
    return Scaffold(
      appBar: AppBar(
        title: Text("products"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.more_vert)),
        ],
      ),
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is AddProductSuccess) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("product added successfully"),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is AddProductFail) {
            print(state.error);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<CategoryProductsEvent, CategoryProductState>(
          bloc: bloc,
          builder: (BuildContext context, CategoryProductState productState) {
            List<ParseObject> productNotAddedFromSparePart = [];
            if (productState is GetCategoryProductSuccess) {
              productState?.alreadyAdded?.forEach((productAdded) {
                ParseObject object =
                    productAdded.get<ParseObject>('spare_part_id');
                productNotAddedFromSparePart = productState?.products
                    ?.where((item) => item.objectId != object.objectId)
                    ?.toList();
              });
            }
            if (productState is GetCategoryProductsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (productState is GetCategoryProductSuccess) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 15,
                ),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: productNotAddedFromSparePart.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: productNotAddedFromSparePart[index],
                        bloc: bloc,
                        onPressed: () async {
                          return await showDialog(
                              context: context,
                              builder: (ctx) {
                                return BlocBuilder<CategoryProductsEvent,
                                    CategoryProductState>(
                                  bloc: bloc,
                                  builder: (BuildContext context,
                                      CategoryProductState state) {
                                    if (state is AddProductSuccess) {
                                      Navigator.pop(context);
                                    }
                                    if (state is AddProductFail) {
                                      Navigator.pop(ctx);
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
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (value) => _price =
                                                    double.parse(value),
                                                validator: (value) {
                                                  if (value.length == 0) {
                                                    return "price cant be empty";
                                                  }
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                color: Colors.orange
                                                    .withOpacity(0.8),
                                                child: Text("Add product"),
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _formKey.currentState
                                                        .save();
                                                    bloc.dispatch(
                                                        AddProductToCategory(
                                                            productState
                                                                    .products[
                                                                index],
                                                            _price));
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
                      );
                    }),
              );
            } else if (productState is GetCategoryProductFail) {
              return Center(
                child: Text(productState.error),
              );
            } 
          },
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
