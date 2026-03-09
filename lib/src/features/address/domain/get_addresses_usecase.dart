import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/address_model/address_response.dart';
import 'package:myvegiz_flutter/src/remote/repositories/repository_impl.dart';

class GetAddressesUseCase implements UseCase<AddressResponse, String> {
  final Repository _repository;

  GetAddressesUseCase(this._repository);

  @override
  Future<Either<Failure, AddressResponse>> call(String params) async {
    return await _repository.getAddressesByClientCode(params);
  }
}
