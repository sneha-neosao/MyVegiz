import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/profile_details_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/wish_list_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/profile_details_model/profile_details_response.dart';
import '../../../../core/utils/logger.dart';

part 'profile_details_event.dart';
part 'profile_details_state.dart';

/// Handles state management for *Profile Details** and its related entities.

class ProfileDetailsBloc extends Bloc<ProfileDetailsEvent, ProfileDetailsState> {
  final ProfileDetailsUseCase _profileDetailsUseCase;

  ProfileDetailsBloc(this._profileDetailsUseCase)
      : super(ProfileDetailsInitialState()) {
    on<ProfileDetailsGetEvent>(_profileDetails);
  }

  Future _profileDetails(ProfileDetailsGetEvent event, Emitter emit) async {
    emit(ProfileDetailsLoadingState());

    final result = await _profileDetailsUseCase(
      ProfileDetailsParams(
        clientCode: event.clientCode,
      ),
    );

    result.fold(
          (l) => emit(ProfileDetailsFailureState(l.message)),
          (r) => emit(ProfileDetailsSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE ProfileDetailsBloc =====");
    return super.close();
  }
}
