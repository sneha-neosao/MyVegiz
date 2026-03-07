import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myvegiz_flutter/src/features/cart/domain/update_cart_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';

part 'update_cart_event.dart';
part 'update_cart_state.dart';

class UpdateCartBloc extends Bloc<UpdateCartEvent, UpdateCartState> {
  final UpdateCartUseCase _updateCartUseCase;

  UpdateCartBloc(this._updateCartUseCase) : super(UpdateCartInitial()) {
    on<UpdateCartQunatyEvent>((event, emit) async {
      emit(UpdateCartLoading());
      final result = await _updateCartUseCase.call(event.params);
      result.fold(
        (failure) => emit(UpdateCartFailure(failure.message)),
        (response) => emit(UpdateCartSuccess(response)),
      );
    });
  }
}
