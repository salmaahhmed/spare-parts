import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class CategoryProductsEvent extends Equatable {
  CategoryProductsEvent([List props = const []]) : super(props);
}

class GetCategoryProducts extends CategoryProductsEvent {
  final ParseObject category;

  GetCategoryProducts(this.category);

  @override
  String toString() => 'GetCategoryProducts';
}


