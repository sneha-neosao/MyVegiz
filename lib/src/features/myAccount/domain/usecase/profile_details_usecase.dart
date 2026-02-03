import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';
import 'package:myvegiz_flutter/src/remote/models/profile_details_model/profile_details_response.dart';

import '../../../../remote/repositories/repository_impl.dart';

/// Domain layer use case for fetching profile details , validates inputs and calls repository method.

class ProfileDetailsUseCase implements UseCase<ProfileDetailsResponse, ProfileDetailsParams> {
  final Repository _authRepository;
  const ProfileDetailsUseCase(this._authRepository);

  @override
  Future<Either<Failure, ProfileDetailsResponse>> call(ProfileDetailsParams params) async {

    final result = await _authRepository.profile_details(params);

    return result;
  }
}

class ProfileDetailsParams extends Equatable {
  final String clientCode;

  const ProfileDetailsParams({
    required this.clientCode,
  });

  @override
  List<Object?> get props => [
    clientCode,
  ];
}
