import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class CategoryProductState extends Equatable {}

class GetCategoryProductSuccess extends CategoryProductState {
  final List<ParseObject> products;
  final List<String> alreadyAddedProducts;
  final List<ParseObject> alreadyAdded;
  GetCategoryProductSuccess(this.products, this.alreadyAdded, this.alreadyAddedProducts);

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

class AddProductLoading extends CategoryProductState {
  @override
  String toString() => 'AddProductLoading';
}

class AddProductSuccess extends CategoryProductState {
  final ParseObject product;

  AddProductSuccess(this.product);
  @override
  String toString() => 'AddProductSuccess';
}

class AddProductFail extends CategoryProductState {
  final String error;

  AddProductFail(this.error);
  @override
  String toString() => 'AddProductFail: $error';
}
