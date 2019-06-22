import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparepart/bloc/category_products/category_products_bloc.dart';
import 'package:sparepart/bloc/category_products/category_products_event.dart';
import 'package:sparepart/bloc/order/order_bloc.dart';
import 'package:sparepart/bloc/spare_part_category/category_bloc.dart';
import 'package:sparepart/bloc/spare_part_category/category_event.dart';
import 'package:sparepart/bloc/spare_part_category/category_state.dart';
import 'package:sparepart/page/order_page.dart';
import 'package:sparepart/page/products_page.dart';
import 'package:sparepart/widget/category_card.dart';
import 'package:sparepart/widget/orders_icon_widget.dart';

class HomePage extends StatelessWidget {
  final CategoryBloc bloc;
  const HomePage(this.bloc, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => OrderPage(
                              orderBloc: BlocProvider.of<OrderBloc>(context))));
                },
                child:
                    OrderIcon(orderBloc: BlocProvider.of<OrderBloc>(context)))),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.more_vert)),
        ],
      ),
      body: BlocBuilder<CategoryEvent, CategoryState>(
        bloc: bloc..dispatch(GetCategories()),
        builder: (BuildContext context, CategoryState state) {
          if (state is GetCategoriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetCategorySuccess) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Select a category",
                      style: Theme.of(context).textTheme.body2.copyWith(
                            fontSize: 14,
                          )),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: state.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryCard(
                          BlocProvider.of<CategoryProductBloc>(context),
                          category: state.categories[index],
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          } else if (state is GetCategoryFail) {
            return Center(child: Text(state.error));
          } else if (state is GetCategoryEmpty) {
            return Center(child: Text(state.error));
          }
        },
      ),
    );
  }
}
