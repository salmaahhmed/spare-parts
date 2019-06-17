import 'dart:core';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/data/model/subscription_model.dart';

class Supplier extends ParseUser implements ParseCloneable {
  Supplier(String username, String password, String emailAddress)
      : super(username, password, emailAddress);

  Supplier.clone() : this(null, null, null);

  @override
  Supplier clone(Map<String, dynamic> map) => Supplier.clone()..fromJson(map);

  static const String keySupplierLogo = 'supplier_logo';
  static const String keyUserId = 'user_id';
  static const String keyLocation = 'location';
  static const String keyUserName = 'user_name';
  static const String keyEmail = 'email';
  static const String keySubscription = "subscription";

  String get userId => get<String>(keyUserId);
  set userId(String userId) => set<String>(keyUserId, userId);

  String get supplierLogo => get<String>(keySupplierLogo);
  set supplierLogo(String supplierLogo) =>
      set<String>(keySupplierLogo, supplierLogo);

  String get userName => get<String>(keyUserName);
  set userName(String userName) => set<String>(keyUserName, userName);

  String get email => get<String>(keyEmail);
  set email(String email) => set<String>(keyEmail, email);

  Subscription get subscription => get<Subscription>(keySubscription);
}
