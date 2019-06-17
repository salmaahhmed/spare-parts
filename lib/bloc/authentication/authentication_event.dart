import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:sparepart/data/model/supplier_model.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {

  @override
  String toString() => 'LoggedIn { supplier: username }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
