import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  CategoryEvent([List props = const []]) : super(props);
}

class GetCategories extends CategoryEvent {
  GetCategories();

  @override
  String toString() => 'getCategories {}}';
}

class GetCategoryProducts extends CategoryEvent {}
