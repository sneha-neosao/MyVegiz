import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../remote/repositories/repository_impl.dart';
import '../../../remote/models/common_response.dart';

class UpdateAddressUseCase
    implements UseCase<CommonResponse, UpdateAddressParams> {
  final AuthRepositoryImpl repository;

  UpdateAddressUseCase(this.repository);

  @override
  Future<Either<Failure, CommonResponse>> call(
    UpdateAddressParams params,
  ) async {
    return await repository.updateClientAddress(params);
  }
}

class UpdateAddressParams {
  final String id;
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

  UpdateAddressParams({
    required this.id,
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
