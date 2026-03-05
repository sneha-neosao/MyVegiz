import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/cart_model/add_to_cart_response.dart';

import '../../../remote/repositories/repository_impl.dart';

class AddToCartUseCase extends UseCase<AddToCartResponse, AddToCartParams> {
  final Repository _repository;

  AddToCartUseCase(this._repository);

  @override
  Future<Either<Failure, AddToCartResponse>> call(
    AddToCartParams params,
  ) async {
    return await _repository.addToCart(params);
  }
}

class AddToCartParams extends Equatable {
  final String clientCode;
  final String price;
  final String productCode;
  final String productName;
  final String quantity;
  final String sellingQuantity;
  final String unit;
  final String unitId;

  const AddToCartParams({
    required this.clientCode,
    required this.price,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.sellingQuantity,
    required this.unit,
    required this.unitId,
  });

  @override
  List<Object?> get props => [
    clientCode,
    price,
    productCode,
    productName,
    quantity,
    sellingQuantity,
    unit,
    unitId,
  ];
}
