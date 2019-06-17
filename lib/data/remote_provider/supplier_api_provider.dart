import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/data/remote_provider/api_response.dart';

class SupplierApiProvider {
  Future<ParseObject> loginSupplier(String userName, String password) async {
    ParseObject userRes;
    try {
      QueryBuilder<ParseObject> queryUser =
          QueryBuilder<ParseObject>(ParseObject('_User'))
            ..whereEqualTo("username", userName);
      userRes = await getApiResponse(await queryUser.query()).result;

      QueryBuilder<ParseObject> querySupplier =
          QueryBuilder<ParseObject>(ParseObject('supplier'))
            ..whereEqualTo('user_id', userRes.toPointer());

      final ParseObject supplierRes =
          await getApiResponse(await querySupplier.query()).result;

      if (supplierRes != null) {
        final ParseUser user =
            ParseUser(userRes.get("username"), password, userRes.get("email"));
        final ParseResponse loginResponse = await user.login();
        if (loginResponse.success) {
          return loginResponse.result;
        }
      }
    } catch (e) {
      print(e);
    }
    return userRes;
  }

  Future<bool> isLoggedIn() async {
    return await ParseUser.currentUser() == null ? false : true;
  }

  Future<void> deleteUser() async {
    ParseUser user = await ParseUser.currentUser();

    user.logout(deleteLocalUserData: true);
  }
}
