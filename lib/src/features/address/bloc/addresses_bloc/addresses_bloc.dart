import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/address/domain/get_addresses_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/address_model/address_response.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddressesUseCase _getAddressesUseCase;

  AddressBloc(this._getAddressesUseCase) : super(AddressInitial()) {
    on<FetchAddressesEvent>(_onFetchAddresses);
  }

  Future<void> _onFetchAddresses(
    FetchAddressesEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoading());
    final result = await _getAddressesUseCase.call(event.clientCode);
    result.fold(
      (failure) => emit(AddressError(failure.message)),
      (response) => emit(AddressLoaded(response)),
    );
  }
}
