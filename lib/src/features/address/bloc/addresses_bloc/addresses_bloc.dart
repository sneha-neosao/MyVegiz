import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/address/domain/delete_address_usecase.dart';
import 'package:myvegiz_flutter/src/features/address/domain/get_addresses_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/address_model/address_response.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddressesUseCase _getAddressesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

  AddressBloc(this._getAddressesUseCase, this._deleteAddressUseCase)
    : super(AddressInitial()) {
    on<FetchAddressesEvent>(_onFetchAddresses);
    on<DeleteAddressEvent>(_onDeleteAddress);
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

  Future<void> _onDeleteAddress(
    DeleteAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(DeleteAddressLoading());
    final result = await _deleteAddressUseCase.call(
      DeleteAddressParams(id: event.id, clientCode: event.clientCode),
    );
    result.fold(
      (failure) => emit(DeleteAddressError(failure.message)),
      (response) => emit(DeleteAddressSuccess(response.message ?? '')),
    );
  }
}
