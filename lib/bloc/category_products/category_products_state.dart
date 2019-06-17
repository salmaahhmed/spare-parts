import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class CategoryProductState extends Equatable {}

class GetCategoryProductSuccess extends CategoryProductState {
  final List<ParseObject> products;

  GetCategoryProductSuccess(this.products);

  @override
  String toString() => 'GetCategoryProductSuccess { size: ${products.length} }';
}

class GetCategoryProductsLoading extends CategoryProductState {
  @override
  String toString() => 'GetCategoryProductsLoading';
}

class GetCategoryProductFail extends CategoryProductState {
  final String error;

  GetCategoryProductFail(this.error);

  @override
  String toString() => 'GetCategoryProductFail { error: $error }';
}

class CategoryProductStateEmpty extends CategoryProductState {
  final String error;

  CategoryProductStateEmpty(this.error);

  @override
  String toString() => 'CategoryProductStateEmpty { error: $error }';
}
