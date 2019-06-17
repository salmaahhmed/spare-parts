import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CategoryCard extends StatelessWidget {
  final ParseObject category;

  const CategoryCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Image.network(category.get("image")),
          Text(category.get("type"))
        ],
      ),
    );
  }
}
