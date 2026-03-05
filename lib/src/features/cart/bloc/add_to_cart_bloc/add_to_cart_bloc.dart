import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/cart/domain/add_to_cart_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/cart_model/add_to_cart_response.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final AddToCartUseCase _addToCartUseCase;

  AddToCartBloc(this._addToCartUseCase) : super(AddToCartInitial()) {
    on<AddProductToCartEvent>(_onAddProductToCart);
  }

  Future<void> _onAddProductToCart(
    AddProductToCartEvent event,
    Emitter<AddToCartState> emit,
  ) async {
    emit(AddToCartLoading());

    final result = await _addToCartUseCase(event.params);

    result.fold(
      (failure) => emit(AddToCartFailure(failure!.message)),
      (response) => emit(AddToCartSuccess(response)),
    );
  }
}
