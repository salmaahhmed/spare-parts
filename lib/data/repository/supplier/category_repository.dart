import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class CategoryRepository {
  Future<List<ParseObject>> getCategories();
}
