import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'api_response.dart';

class OrderApiProvider{
  Future<List<ParseObject>> getOrders(ParseObject user) async {
    List<ParseObject> ordersList =[];

    // select supplier id where user id equals
    QueryBuilder<ParseObject> queryUser =
    QueryBuilder<ParseObject>(ParseObject('supplier'));
    queryUser.whereEqualTo("user_id", user);

    // get list of products that supplier supplies
    QueryBuilder<ParseObject> querySupplierSpareParts =
    QueryBuilder<ParseObject>(ParseObject('supplier_spare_part'));
    querySupplierSpareParts.whereMatchesQuery("supplier_id", queryUser);
    List<ParseObject> supplierSpareParts = getApiResponse(await querySupplierSpareParts.query()).results;

    //get attached orders to this supplier
    
    for (ParseObject value in supplierSpareParts) {
      QueryBuilder<ParseObject> queryOrderSupplierSpareParts =
      QueryBuilder<ParseObject>(ParseObject('order_supplier_spare_part'));
      querySupplierSpareParts.whereEqualTo("supplier_spare_part_id", value);
      ordersList.add( getApiResponse(await queryOrderSupplierSpareParts.query()).result);

      }
    return ordersList;
     
  }
}