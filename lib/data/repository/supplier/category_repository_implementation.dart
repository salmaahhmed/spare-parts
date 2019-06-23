import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/data/remote_provider/category_api_provider.dart';
import 'package:sparepart/data/repository/supplier/category_repository.dart';

class CategoryRepoImplementation extends CategoryRepository {
  final CategoryApiProvider categoryApiProvider;

  CategoryRepoImplementation(this.categoryApiProvider);

  @override
  Future<List<ParseObject>> getCategories() {
    return categoryApiProvider.getCategories();
  }

  @override
  Future<List<ParseObject>> getProductCategories(ParseObject category) {
    return categoryApiProvider.getProductByCategory(category);
  }

  Future<int> addProductToCategory(
      ParseObject staticProduct, double price) {
    return categoryApiProvider.addProduct(staticProduct, price);
  }

  @override
  Future<List<ParseObject>> getSupplierProducts() {
    return categoryApiProvider.getSupplierProducts();
  }
}
