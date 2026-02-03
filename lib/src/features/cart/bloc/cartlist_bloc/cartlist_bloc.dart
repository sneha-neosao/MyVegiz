import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/cart/domain/cart_list_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/wish_list_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/cart_model/cart_list_response.dart';
import '../../../../core/utils/logger.dart';

part 'cartlist_event.dart';
part 'cartlist_state.dart';

/// Handles state management for *Cart List** and its related entities.

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  final CartListUseCase _cartListUseCase;

  CartListBloc(this._cartListUseCase)
      : super(CartListInitialState()) {
    on<CartListGetEvent>(_cartList);
  }

  Future _cartList(CartListGetEvent event, Emitter emit) async {
    emit(CartListLoadingState());

    final result = await _cartListUseCase(
      CartListParams(
          clientCode: event.clientCode,
      ),
    );

    result.fold(
          (l) => emit(CartListFailureState(l.message)),
          (r) => emit(CartListSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE CartListBloc =====");
    return super.close();
  }
}
