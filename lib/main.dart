import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_bloc.dart';
import 'package:sparepart/bloc/authentication/authentication_event.dart';
import 'package:sparepart/bloc/authentication/authentication_state.dart';
import 'package:sparepart/bloc/spare_part_category/category_bloc.dart';
import 'package:sparepart/data/parse_keys.dart';
import 'package:sparepart/data/remote_provider/category_api_provider.dart';
import 'package:sparepart/data/remote_provider/supplier_api_provider.dart';
import 'package:sparepart/data/repository/supplier/category_repository.dart';
import 'package:sparepart/data/repository/supplier/category_repository_implementation.dart';
import 'package:sparepart/data/repository/supplier/supplier_repository.dart';
import 'package:sparepart/page/home_page.dart';
import 'package:sparepart/page/login/login_page.dart';
import 'data/repository/supplier/supplier_repository_implementation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async {
  Parse().initialize(
    keyParseApplicationId,
    keyParseServerUrl,
    masterKey: keyParseMasterKey,
    debug: true,
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SupplierApiProvider supplierApiProvider = SupplierApiProvider();

  final SupplierRepoImplementation supplierRepository =
      SupplierRepoImplementation(supplierApiProvider);

  runApp(
    App(
      supplierRepository: supplierRepository,
    ),
  );
}

class App extends StatelessWidget {
  final SupplierRepository supplierRepository;

  App({
    Key key,
    @required this.supplierRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationBloc(
        supplierRepository: SupplierRepoImplementation(SupplierApiProvider()));
    return MaterialApp(
      home: BlocProviderTree(
        blocProviders: [
          BlocProvider<AuthenticationBloc>(
            builder: (BuildContext context) => auth,
          ),
          BlocProvider<CategoryBloc>(
            builder: (BuildContext context) =>
                CategoryBloc(CategoryRepoImplementation(CategoryApiProvider())),
          ),
        ],
        child: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: auth..dispatch(AppStarted()),
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPageMain(supplierRepository: supplierRepository);
            }
            if (state is AuthenticationLoading) {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
