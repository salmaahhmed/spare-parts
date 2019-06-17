import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/category_products/category_products_bloc.dart';
import 'package:sparepart/bloc/category_products/category_products_event.dart';
import 'package:sparepart/page/products_page.dart';

class CategoryCard extends StatelessWidget {
  final ParseObject category;
  const CategoryCard({Key key, this.category,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
         _redirectToPage(
          context,
          ProductsPage(
            category: category,
            bloc: BlocProvider.of<CategoryProductBloc>(context)
              ..dispatch(GetCategoryProducts(category)),
          ));},
      child: Card(
        child: Row(
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
                child: Container(
                    height: 50,
                    width: 50,
                    child: Image.network(category.get("image")))),
            Text(
              category.get("type"),
              style: Theme.of(context).textTheme.body2,
            )
          ],
        ),
      ),
    );
  }
}

_redirectToPage(BuildContext context, Widget page) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    MaterialPageRoute newRoute =
        MaterialPageRoute(builder: (BuildContext context) => page);

    Navigator.of(context).push(newRoute);
  });
}
