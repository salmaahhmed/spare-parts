import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/category_products/category_products_event.dart';
import 'package:sparepart/bloc/category_products/category_products_state.dart';
import 'package:sparepart/data/repository/supplier/category_repository.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductsEvent, CategoryProductState> {
  final CategoryRepository categoryProductApiProvider;

  CategoryProductBloc(this.categoryProductApiProvider);
  @override
  CategoryProductState get initialState => GetCategoryProductsLoading();

  @override
  Stream<CategoryProductState> mapEventToState(
      CategoryProductsEvent event) async* {
    if (event is GetCategoryProducts) {
      yield GetCategoryProductsLoading();
      try {
        List<ParseObject> products = await categoryProductApiProvider
            .getProductCategories(event.category);
        if (products.isNotEmpty) {
          yield GetCategoryProductSuccess(products);
        }
      } catch (e) {
        yield GetCategoryProductFail(e.toString());
      }
    }
  }
}
