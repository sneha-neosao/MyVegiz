import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../remote/repositories/repository_impl.dart';
import '../../../remote/models/common_response.dart';

class AddAddressUseCase implements UseCase<CommonResponse, AddAddressParams> {
  final AuthRepositoryImpl repository;

  AddAddressUseCase(this.repository);

  @override
  Future<Either<Failure, CommonResponse>> call(AddAddressParams params) async {
    return await repository.addClientAddress(params);
  }
}

class AddAddressParams {
  final String clientCode;
  final String address;
  final String latitude;
  final String longitude;
  final String addressType;
  final String flat;
  final String landMark;
  final String directionToReach;
  final String areaCode;
  final String cityCode;

  AddAddressParams({
    required this.clientCode,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.addressType,
    required this.flat,
    required this.landMark,
    required this.directionToReach,
    required this.areaCode,
    required this.cityCode,
  });
}
