import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/category_products/category_products_event.dart';
import 'package:sparepart/bloc/category_products/category_products_state.dart';
import 'package:sparepart/data/remote_provider/category_api_provider.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductsEvent, CategoryProductState> {
  final CategoryApiProvider categoryApiProvider;

  CategoryProductBloc(this.categoryApiProvider);
  @override
  CategoryProductState get initialState => GetCategoryProductsLoading();

  @override
  Stream<CategoryProductState> mapEventToState(
      CategoryProductsEvent event) async* {
    if (event is GetCategoryProducts) {
      yield GetCategoryProductsLoading();
      try {
        List<ParseObject> products = await categoryApiProvider
            .getProductByCategory(event.category);
        if (products.isNotEmpty) {
          yield GetCategoryProductSuccess(products);
        }
      } catch (e) {
        yield GetCategoryProductFail(e.toString());
      }
    }
  }
}
