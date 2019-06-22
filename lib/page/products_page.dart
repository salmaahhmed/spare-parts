import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/category_products/category_products_bloc.dart';
import 'package:sparepart/bloc/category_products/category_products_event.dart';
import 'package:sparepart/bloc/category_products/category_products_state.dart';
import 'package:sparepart/widget/orders_icon_widget.dart';
import 'package:sparepart/widget/product_card.dart';

class ProductsPage extends StatelessWidget {
  final ParseObject category;
  final CategoryProductBloc bloc;
  const ProductsPage({Key key, this.category, this.bloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("products"),
        leading:
            Padding(padding: EdgeInsets.only(left: 10), child: OrderIcon()),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.more_vert)),
        ],
      ),
      body: BlocBuilder<CategoryProductsEvent, CategoryProductState>(
        bloc: bloc,
        builder: (BuildContext context, CategoryProductState state) {
          if (state is GetCategoryProductsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetCategoryProductSuccess) {
            return Padding(
              padding: EdgeInsets.only(top: 15,),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: state.products[index],
                    bloc: bloc,
                  );
                },
              ),
            );
          } else if (state is GetCategoryProductFail) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
