import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_event.dart';
import 'package:sparepart/bloc/spare_part_category/category_bloc.dart';
import 'package:sparepart/bloc/spare_part_category/category_event.dart';
import 'package:sparepart/bloc/spare_part_category/category_state.dart';
import 'package:sparepart/widget/category_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            child: Text('logout'),
            onPressed: () {
             // authenticationBloc.dispatch(LoggedOut());
            },
          ),
        ],
      ),
      body: BlocBuilder<CategoryEvent, CategoryState>(
        bloc: BlocProvider.of<CategoryBloc>(context)..dispatch(GetCategories()),
        builder: (BuildContext context, CategoryState state) {
          if (state is GetCategoriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetCategorySuccess) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryCard(category: state.categories[index]);
              },
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
