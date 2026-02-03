import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/home/domain/usecase/vegetable_grocery_cart_count_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/cart_model/cart_count_response.dart';
import '../../../../core/utils/logger.dart';

part 'vegetable_grocery_cart_count_event.dart';
part 'vegetable_grocery_cart_count_state.dart';

/// Handles state management for *Cart Count** and its related entities.

class CartCountBloc extends Bloc<CartCountEvent, VegetableGroceryCartCountState> {
  final VegetableGroceryCartCountUseCase _vegetableGroceryCartCountUseCase;

  CartCountBloc(this._vegetableGroceryCartCountUseCase)
      : super(VegetableGroceryCartCountInitialState()) {
    on<CartCountGetEvent>(_wishList);
  }

  Future _wishList(CartCountGetEvent event, Emitter emit) async {
    emit(VegetableGroceryCartCountLoadingState());

    final result = await _vegetableGroceryCartCountUseCase(
      VegetableGroceryCartCountParams(
        clientCode: event.clientCode,
      ),
    );

    result.fold(
          (l) => emit(VegetableGroceryCartCountFailureState(l.message)),
          (r) => emit(VegetableGroceryCartCountSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE CartCountBloc =====");
    return super.close();
  }
}
