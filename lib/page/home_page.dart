import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_event.dart';
import 'package:sparepart/bloc/spare_part_category/category_bloc.dart';
import 'package:sparepart/bloc/spare_part_category/category_state.dart';
import 'package:sparepart/data/remote_provider/category_api_provider.dart';
import 'package:sparepart/data/repository/supplier/category_repository_implementation.dart';
import 'package:sparepart/widget/category_card.dart';

class HomePage extends StatelessWidget {
  static final categoryApiProvider = CategoryApiProvider();

  static final categoryRepository =
      CategoryRepoImplementation(categoryApiProvider);
  CategoryBloc categoryBloc = CategoryBloc(categoryRepository);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            child: Text('logout'),
            onPressed: () {
              authenticationBloc.dispatch(LoggedOut());
            },
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: categoryBloc,
        builder: (BuildContext ctx, CategoryState state) {
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
