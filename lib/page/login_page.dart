

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_bloc.dart';
import 'package:sparepart/bloc/login/login_bloc.dart';
import 'package:sparepart/data/repository/supplier/supplier_repository.dart';
import 'package:sparepart/page/login_form.dart';

class LoginPagee extends StatelessWidget {
  final SupplierRepository supplierRepository;

  LoginPagee({Key key, @required this.supplierRepository})
      : assert(supplierRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        builder: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            supplierRepository: supplierRepository,
          );
        },
        child: LoginPage(),
      ),
    );
  }
}