import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/address/domain/add_address_usecase.dart';
import 'package:myvegiz_flutter/src/features/address/domain/delete_address_usecase.dart';
import 'package:myvegiz_flutter/src/features/address/domain/get_addresses_usecase.dart';
import 'package:myvegiz_flutter/src/features/address/domain/update_address_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/address_model/address_response.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddressesUseCase _getAddressesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;

  AddressBloc(
    this._getAddressesUseCase,
    this._deleteAddressUseCase,
    this._addAddressUseCase,
    this._updateAddressUseCase,
  ) : super(AddressInitial()) {
    on<FetchAddressesEvent>(_onFetchAddresses);
    on<DeleteAddressEvent>(_onDeleteAddress);
    on<AddAddressEvent>(_onAddAddress);
    on<UpdateAddressEvent>(_onUpdateAddress);
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

  Future<void> _onAddAddress(
    AddAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddAddressLoading());
    final result = await _addAddressUseCase.call(
      AddAddressParams(
        clientCode: event.clientCode,
        address: event.address,
        latitude: event.latitude,
        longitude: event.longitude,
        addressType: event.addressType,
        flat: event.flat,
        landMark: event.landMark,
        directionToReach: event.directionToReach,
        areaCode: event.areaCode,
        cityCode: event.cityCode,
      ),
    );
    result.fold(
      (failure) => emit(AddAddressError(failure.message)),
      (response) => emit(AddAddressSuccess(response.message ?? '')),
    );
  }

  Future<void> _onUpdateAddress(
    UpdateAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(UpdateAddressLoading());
    final result = await _updateAddressUseCase.call(
      UpdateAddressParams(
        id: event.id,
        clientCode: event.clientCode,
        address: event.address,
        latitude: event.latitude,
        longitude: event.longitude,
        addressType: event.addressType,
        flat: event.flat,
        landMark: event.landMark,
        directionToReach: event.directionToReach,
        areaCode: event.areaCode,
        cityCode: event.cityCode,
      ),
    );
    result.fold(
      (failure) => emit(UpdateAddressError(failure.message)),
      (response) => emit(UpdateAddressSuccess(response.message ?? '')),
    );
  }
}
