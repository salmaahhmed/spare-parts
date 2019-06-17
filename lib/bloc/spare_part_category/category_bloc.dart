import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sparepart/bloc/spare_part_category/category_event.dart';
import 'package:sparepart/bloc/spare_part_category/category_state.dart';
import 'package:sparepart/data/repository/supplier/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository);
  @override
  get initialState => GetCategoriesLoading();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is GetCategories) {
      yield GetCategoriesLoading();
      try {
        List<ParseObject> parseObjects =
            await categoryRepository.getCategories();
        if (parseObjects.isNotEmpty) {
          yield GetCategorySuccess(parseObjects);
        } else {
          yield GetCategoryEmpty("no categories available");
        }
      } catch (e) {
        yield GetCategoryFail(e.toString());
      }
    }
  }
}
