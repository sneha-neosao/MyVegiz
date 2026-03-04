import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/remote/models/category_by_product_model/category_by_product_response.dart';
import '../../../domain/usecase/search_product_usecase.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final SearchProductUseCase _searchProductUseCase;

  SearchProductBloc(this._searchProductUseCase) : super(SearchProductInitial()) {
    on<SearchProductByKeywordEvent>(_onSearchProductByKeyword);
  }

  Future<void> _onSearchProductByKeyword(
      SearchProductByKeywordEvent event,
      Emitter<SearchProductState> emit,
      ) async {
    emit(SearchProductLoading());

    final result = await _searchProductUseCase(
      SearchProductParams(
        keyword: event.keyword,
        offset: event.offset,
        mainCategoryCode: event.mainCategoryCode,
        cityCode: event.cityCode,
        clientCode: event.clientCode,
      ),
    );

    result.fold(
          (failure) => emit(SearchProductFailure(failure.message)),
          (response) => emit(SearchProductSuccess(response)),
    );
  }
}
