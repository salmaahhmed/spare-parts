import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class CategoryState extends Equatable {}

class GetCategoriesLoading extends CategoryState {
  @override
  String toString() => 'GetCategoriesLoading';
}


class GetCategorySuccess extends CategoryState {
  final List<ParseObject> categories;

  GetCategorySuccess(this.categories);

  @override
  String toString() => 'getCategoriesSuccess { size: ${categories.length} }';
}

class GetCategoryFail extends CategoryState {
  final String error;

  GetCategoryFail(this.error);

  @override
  String toString() => 'getCategoriesFail { error: $error }';
}

class GetCategoryEmpty extends CategoryState {
  final String error;

  GetCategoryEmpty(this.error);

  @override
  String toString() => 'getCategoriesEmpty {"error: $error"}';
}
