import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../remote/repositories/repository_impl.dart';
import '../../../remote/models/common_response.dart';

class DeleteAddressUseCase
    implements UseCase<CommonResponse, DeleteAddressParams> {
  final AuthRepositoryImpl repository;

  DeleteAddressUseCase(this.repository);

  @override
  Future<Either<Failure, CommonResponse>> call(
    DeleteAddressParams params,
  ) async {
    return await repository.deleteClientAddress(params);
  }
}

class DeleteAddressParams {
  final String id;
  final String clientCode;

  DeleteAddressParams({required this.id, required this.clientCode});
}
