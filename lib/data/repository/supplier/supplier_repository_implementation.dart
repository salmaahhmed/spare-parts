import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/data/model/supplier_model.dart';
import 'package:sparepart/data/remote_provider/supplier_api_provider.dart';
import 'package:sparepart/data/repository/supplier/supplier_repository.dart';

class SupplierRepoImplementation extends SupplierRepository {
  final SupplierApiProvider _supplierApiProvider;

  SupplierRepoImplementation(this._supplierApiProvider);

  @override
  Future<ParseObject> loginSupplier({String userName, String password}) async {
    return await _supplierApiProvider.loginSupplier(userName, password);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _supplierApiProvider.isLoggedIn();
  }

  @override
  Future<void> deleteUser() async {
    return await _supplierApiProvider.deleteUser();
  }
}
