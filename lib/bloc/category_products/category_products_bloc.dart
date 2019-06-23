import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/category_products/category_products_event.dart';
import 'package:sparepart/bloc/category_products/category_products_state.dart';
import 'package:sparepart/data/repository/supplier/category_repository.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductsEvent, CategoryProductState> {
  final CategoryRepository categoryRepository;

  CategoryProductBloc(this.categoryRepository);
  @override
  CategoryProductState get initialState => GetCategoryProductsLoading();

  @override
  Stream<CategoryProductState> mapEventToState(
      CategoryProductsEvent event) async* {
    if (event is GetCategoryProducts) {
      yield GetCategoryProductsLoading();
      try {
        List<ParseObject> products =
            await categoryRepository.getProductCategories(event.category);

        List<ParseObject> alreadyAdded =
            await categoryRepository.getSupplierProducts();
        if (products.isNotEmpty) {
          yield GetCategoryProductSuccess(products, alreadyAdded);
        }
      } catch (e) {
        yield GetCategoryProductFail(e.toString());
      }
    } else if (event is AddProductToCategory) {
      yield AddProductLoading();

      try {
        bool productAdded = await categoryRepository.addProductToCategory(
            event.product, event.price);
        if (productAdded) {
          yield AddProductSuccess(event.product);
        } else if (!productAdded) {
          yield AddProductFail("an error occured");
        } else {
          yield AddProductAlreadyExist("product already added");
        }
      } catch (e) {
        yield AddProductFail(e.toString());
      }
    }
  }
}
