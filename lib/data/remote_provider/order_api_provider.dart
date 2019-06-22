import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'api_response.dart';
import 'supplier_api_provider.dart';

class OrderApiProvider {
  Future<List<ParseObject>> getOrders(ParseObject user) async {
    List<ParseObject> ordersList = [];

    // get list of products that supplier supplies
    QueryBuilder<ParseObject> querySupplierSpareParts =
        QueryBuilder<ParseObject>(ParseObject('supplier_spare_part'));
    querySupplierSpareParts.whereEqualTo("supplier_id",
        (await SupplierApiProvider.currentSupplier()).toPointer());
    List<ParseObject> supplierSpareParts =
        getApiResponse(await querySupplierSpareParts.query()).results;

    //get attached orders to this supplier

    for (ParseObject value in supplierSpareParts) {
      QueryBuilder<ParseObject> queryOrderSupplierSpareParts =
          QueryBuilder<ParseObject>(ParseObject('order_supplier_spare_part'));
      queryOrderSupplierSpareParts.whereEqualTo(
          "supplier_spare_part_id", value.toPointer());
      queryOrderSupplierSpareParts.whereEqualTo("is_accepted", false);
      queryOrderSupplierSpareParts.includeObject([
        "spare_part_id",
        "supplier_spare_part_id",
      ]);
      List<ParseObject> list =
          getApiResponse(await queryOrderSupplierSpareParts.query())?.results ??
              [];
      list.forEach((item) async {
        ParseObject supplier_spare = item.get("supplier_spare_part_id");
        ParseObject spare_part = await fetchParseObjectIfNeeded<ParseObject>(
            supplier_spare.get("spare_part_id"));
        item.set("supplier_spare_part_id",
            supplier_spare..set("spare_part_id", spare_part));
        ordersList.add(item);
      });
    }
    return ordersList;
  }

  Future<ParseObject> acceptOrder(ParseObject acceptedOrder) async {
    acceptedOrder.set("is_accepted", true);
    return getApiResponse(await acceptedOrder.save()).result;
  }
}
