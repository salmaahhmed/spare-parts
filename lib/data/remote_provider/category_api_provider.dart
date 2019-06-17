import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/data/remote_provider/api_response.dart';

class CategoryApiProvider {
  List<ParseObject> categoryRes;
  Future<List<ParseObject>> getCategories() async {
    categoryRes =
        getApiResponse(await ParseObject('spare_part_type').getAll()).results;
    print(categoryRes);
    return categoryRes;
  }

  Future<List<ParseObject>> getProductByCategory(
      ParseObject category) async {
    QueryBuilder<ParseObject> querySparePart =
        QueryBuilder<ParseObject>(ParseObject('spare_part'))
          ..whereEqualTo('spare_part_type_id', category);
    ParseResponse apiResponse = await querySparePart.query();
    return apiResponse.results;
  }
}
