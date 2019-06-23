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
            await categoryRepository.getSupplierProducts(event.category);
        List<String> productsAddedOfSelectedCategory =  categoryRepository.getProductsAddedOfSelectedCategory();
        if (products.isNotEmpty) {
          yield GetCategoryProductSuccess(products, alreadyAdded,productsAddedOfSelectedCategory);
        }
      } catch (e) {
        yield GetCategoryProductFail(e.toString());
      }
    } else if (event is AddProductToCategory) {
      yield AddProductLoading();

      try {
        int productAdded = await categoryRepository.addProductToCategory(
            event.product, event.price);
        if (productAdded == 0) {
          yield AddProductSuccess(event.product);
        } else if (productAdded == 1) {
          yield AddProductFail("an error occured");
        } else {
          yield AddProductFail("product already added");
        }
      } catch (e) {
        yield AddProductFail(e.toString());
      }
    }
  }
}
