import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class CategoryRepository {
  Future<List<ParseObject>> getCategories();
  Future<List<ParseObject>> getProductCategories(ParseObject category);
  Future<bool> addProductToCategory(ParseObject staticProduct, double price);
  Future<List<ParseObject>> getSupplierProducts();
}
