import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/common/domain/usecase/product_details_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/product_details_model/product_details_response.dart';

part 'get_product_details_event.dart';
part 'get_product_details_state.dart';

class GetProductDetailsBloc
    extends Bloc<GetProductDetailsEvent, GetProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  GetProductDetailsBloc({required this.getProductDetailsUseCase})
    : super(GetProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(_onFetchProductDetails);
  }

  Future<void> _onFetchProductDetails(
    FetchProductDetailsEvent event,
    Emitter<GetProductDetailsState> emit,
  ) async {
    emit(GetProductDetailsLoading());
    final result = await getProductDetailsUseCase.call(
      ProductDetailsParams(
        productCode: event.productCode,
        mainCategoryCode: event.mainCategoryCode,
        cityCode: event.cityCode,
        clientCode: event.clientCode,
      ),
    );

    result.fold(
      (failure) => emit(GetProductDetailsError(failure.message)),
      (response) => emit(GetProductDetailsLoaded(response)),
    );
  }
}
