import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/category_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/category_model/category_response.dart';
import '../../../../core/utils/logger.dart';

part 'category_event.dart';
part 'category_state.dart';

/// Handles state management for *Category** and its related entities.

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase _categoryUseCase;

  CategoryBloc(this._categoryUseCase)
      : super(CategoryInitialState()) {
    on<CategoryGetEvent>(_slider);
  }

  Future _slider(CategoryGetEvent event, Emitter emit) async {
    emit(CategoryLoadingState());

    final result = await _categoryUseCase(
      CategoryParams(
        offset: event.offset,
        mainCategoryCode: event.mainCategoryCode,
      ),
    );

    result.fold(
          (l) => emit(CategoryFailureState(l.message)),
          (r) => emit(CategorySuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE CategoryBloc =====");
    return super.close();
  }
}
