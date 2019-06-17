import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_event.dart';
import 'package:sparepart/bloc/login/login_event.dart';
import 'package:sparepart/data/repository/supplier/supplier_repository.dart';

import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SupplierRepository supplierRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.supplierRepository,
    @required this.authenticationBloc,
  })  : assert(supplierRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
      
        if (await supplierRepository.loginSupplier(
            userName: event.username, password: event.password) != null) {
          authenticationBloc.dispatch(LoggedIn());
          yield LoginSuccess();
        } else {
          yield LoginFailure(error: "incorrect username or password");
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
