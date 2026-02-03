import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/add_to_wishlist_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';
import '../../../../core/utils/logger.dart';

part 'add_to_wishlist_event.dart';
part 'add_to_wishlist_state.dart';

/// Handles state management for *Add Product To WishList** and its related entities.

class AddToWishListBloc extends Bloc<AddToWishListEvent, AddToWishListState> {
  final AddToWishListUseCase _addToWishListUseCase;

  AddToWishListBloc(this._addToWishListUseCase)
      : super(AddToWishListInitialState()) {
    on<AddToWishListGetEvent>(_addToWishList);
  }

  Future _addToWishList(AddToWishListGetEvent event, Emitter emit) async {
    emit(AddToWishListLoadingState());

    final result = await _addToWishListUseCase(
      AddToWishListParams(
        productCode: event.productCode,
        clientCode: event.clientCode,
      ),
    );

    result.fold(
          (l) => emit(AddToWishListFailureState(l.message)),
          (r) => emit(AddToWishListSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE AddToWishListBloc =====");
    return super.close();
  }
}
