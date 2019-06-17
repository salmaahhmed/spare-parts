import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class CategoryEvent extends Equatable {
  CategoryEvent([List props = const []]) : super(props);
}

class GetCategories extends CategoryEvent {
  final List<ParseObject> categories;

  GetCategories(this.categories);

  @override
  String toString() => 'getCategories {size: ${categories.length}}';
}

class GetCategoryProducts extends CategoryEvent {}
