import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/cart/domain/delete_cart_item_usecase.dart';
import '../../../../remote/models/common_response.dart';

part 'delete_cart_item_event.dart';
part 'delete_cart_item_state.dart';

class DeleteCartItemBloc
    extends Bloc<DeleteCartItemEvent, DeleteCartItemState> {
  final DeleteCartItemUseCase _deleteCartItemUseCase;

  DeleteCartItemBloc(this._deleteCartItemUseCase)
    : super(DeleteCartItemInitial()) {
    on<DeleteCartItemSubmitEvent>(_onDeleteCartItem);
  }

  Future<void> _onDeleteCartItem(
    DeleteCartItemSubmitEvent event,
    Emitter<DeleteCartItemState> emit,
  ) async {
    emit(DeleteCartItemLoading());

    final result = await _deleteCartItemUseCase(event.params);

    result.fold(
      (failure) => emit(DeleteCartItemFailure(failure.message)),
      (response) => emit(DeleteCartItemSuccess(response)),
    );
  }
}
