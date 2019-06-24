import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/data/remote_provider/api_response.dart';
import 'package:sparepart/data/remote_provider/supplier_api_provider.dart';

class CategoryApiProvider {
  List<ParseObject> categoryRes;
  List<String> productsChosen= [];
  Future<List<ParseObject>> getCategories() async {
    categoryRes =
        getApiResponse(await ParseObject('spare_part_type').getAll()).results;
    print(categoryRes);
    return categoryRes;
  }

  Future<List<ParseObject>> getProductByCategory(ParseObject category) async {
    QueryBuilder<ParseObject> querySparePart =
        QueryBuilder<ParseObject>(ParseObject('spare_part'))
          ..whereEqualTo('spare_part_type_id', category);
    ParseResponse apiResponse = await querySparePart.query();
    return apiResponse.results;
  }

  Future<List<ParseObject>> getSupplierProducts(ParseObject category) async {
    ParseObject supplier = await SupplierApiProvider.currentSupplier();

    QueryBuilder<ParseObject> querySupplierSparePart =
        QueryBuilder<ParseObject>(ParseObject('supplier_spare_part'));
    querySupplierSparePart.includeObject(["spare_part_id","spare_part_type_id"]);
    querySupplierSparePart.whereEqualTo('supplier_id', supplier.toPointer());

    List<ParseObject> products =
        getApiResponse(await querySupplierSparePart.query()).results;
    List<ParseObject> productsByCategory= [];
    productsChosen.clear();
    if(products!=null){
    products.forEach((product){
      if(product.get("spare_part_id").get("spare_part_type_id").objectId==category.objectId)
        productsChosen.add(product.get("spare_part_id").objectId);
        productsByCategory.add(product);
      });
    }
    return productsByCategory;
  }
  List<String> getCategoriesOfProduct(){
    return  productsChosen;
  }

  Future<int> addProduct(ParseObject staticProduct, double price) async {
    ParseObject supplier = await SupplierApiProvider.currentSupplier();
    QueryBuilder<ParseObject> querySupplierSparePart =
        QueryBuilder<ParseObject>(ParseObject('supplier_spare_part'))
          ..whereEqualTo('supplier_id', supplier.toPointer())
          ..whereEqualTo('spare_part_id', staticProduct.toPointer());

    ParseObject product =
        getApiResponse(await querySupplierSparePart.query()).result;

    if (product == null) {
      ParseObject supplierSparePart = ParseObject('supplier_spare_part')
        ..set(
            'supplier_id',
            await SupplierApiProvider.currentSupplier()
              ..toPointer())
        ..set('spare_part_id', staticProduct.toPointer())
        ..set('price', price);
      
      return getApiResponse(await supplierSparePart.save()).success == true ? 0 : 1 ;
    } else {
      return 2;
    }
  }
}
