import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/wish_list_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/add_to_wishlist_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';
import 'package:myvegiz_flutter/src/remote/models/wish_list_model/wish_list_response.dart';
import '../../../../core/utils/logger.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

/// Handles state management for *WishList** and its related entities.

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  final WishListUseCase _wishListUseCase;

  WishListBloc(this._wishListUseCase)
      : super(WishListInitialState()) {
    on<WishListGetEvent>(_wishList);
  }

  Future _wishList(WishListGetEvent event, Emitter emit) async {
    emit(WishListLoadingState());

    final result = await _wishListUseCase(
      WishListParams(
        clientCode: event.clientCode,
        mainCategoryCode: event.mainCategoryCode,
        cityCode: event.cityCode
      ),
    );

    result.fold(
          (l) => emit(WishListFailureState(l.message)),
          (r) => emit(WishListSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE AddToWishListBloc =====");
    return super.close();
  }
}
