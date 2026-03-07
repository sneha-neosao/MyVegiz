import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';

import '../../../remote/repositories/repository_impl.dart';

class UpdateCartUseCase extends UseCase<CommonResponse, UpdateCartParams> {
  final Repository _repository;

  UpdateCartUseCase(this._repository);

  @override
  Future<Either<Failure, CommonResponse>> call(UpdateCartParams params) async {
    return await _repository.updateCart(params);
  }
}

class UpdateCartParams extends Equatable {
  final String cartCode;
  final String quantity;
  final String clientCode;
  final String productCode;
  final String variantsCode;
  final String cityCode;
  final String unit;
  final String unitId;
  final String sellingQuantity;
  final String productName;
  final String price;
  final String count;

  const UpdateCartParams({
    required this.cartCode,
    required this.quantity,
    required this.clientCode,
    required this.productCode,
    required this.variantsCode,
    required this.cityCode,
    required this.unit,
    required this.unitId,
    required this.sellingQuantity,
    required this.productName,
    required this.price,
    required this.count,
  });

  @override
  List<Object?> get props => [
    cartCode,
    quantity,
    clientCode,
    productCode,
    variantsCode,
    cityCode,
    unit,
    unitId,
    sellingQuantity,
    productName,
    price,
    count,
  ];
}
