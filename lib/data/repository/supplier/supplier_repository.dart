import 'package:meta/meta.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/data/model/supplier_model.dart';

abstract class SupplierRepository {
  Future<ParseObject> loginSupplier({@required String userName, @required String password});
  Future<bool> isLoggedIn();
  Future<void> deleteUser();
}
