import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_state.dart';
import 'package:sparepart/data/repository/supplier/supplier_repository.dart';

import 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SupplierRepository supplierRepository;

  AuthenticationBloc({@required this.supplierRepository})
      : assert(supplierRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event,) async* {
    if (event is AppStarted) {
      final bool isLoggedIn = await supplierRepository.isLoggedIn();
      if (isLoggedIn) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated("unauthenticated");
      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await supplierRepository.deleteUser();
      yield AuthenticationUnauthenticated("logging out");
    }
  }
}